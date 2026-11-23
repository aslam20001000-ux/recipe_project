import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:recipe_project/app.dart';
import 'package:recipe_project/data/models/chat_message.dart';
import 'package:recipe_project/data/models/cook_level.dart';
import 'package:recipe_project/data/repository/recipe_repository.dart';
import 'package:recipe_project/l10n/app_localizations_ar.dart';
import 'package:recipe_project/services/chef_assistant.dart';
import 'package:recipe_project/state/chat_controller.dart';

import 'fake_assistant.dart';

String _sse(List<Map<String, Object?>> events) =>
    events.map((e) => 'event: ${e['type']}\ndata: ${jsonEncode(e)}\n\n').join();

Map<String, Object?> _text(String t) => {
  'type': 'content_block_delta',
  'index': 0,
  'delta': {'type': 'text_delta', 'text': t},
};

void main() {
  final repo = RecipeRepository();
  const ctx = AssistantContext(
    userName: 'Ahmed',
    level: CookLevel.beginner,
    languageCode: 'ar',
  );
  const question = [ChatMessage(role: ChatRole.user, text: 'إزاي أعمل كشري؟')];

  group('ClaudeChefAssistant', () {
    ClaudeChefAssistant build(MockClient client) => ClaudeChefAssistant(
      recipes: repo.all,
      apiKey: 'test-key',
      clientFactory: () => client,
    );

    test('streams text deltas and sends a cacheable request', () async {
      late http.Request sent;
      final client = MockClient((request) async {
        sent = request;
        return http.Response(
          _sse([
            {'type': 'message_start', 'message': {}},
            {
              'type': 'content_block_start',
              'index': 0,
              'content_block': {'type': 'text', 'text': ''},
            },
            _text('اغسل '),
            _text('العدس'),
            {
              'type': 'message_delta',
              'delta': {'stop_reason': 'end_turn'},
            },
            {'type': 'message_stop'},
          ]),
          200,
          headers: {'content-type': 'text/event-stream; charset=utf-8'},
        );
      });

      final events = await build(
        client,
      ).reply(history: question, context: ctx).toList();
      final reply = events.whereType<TextChunk>().map((e) => e.text).join();
      expect(reply, 'اغسل العدس');

      expect(sent.url.toString(), 'https://api.anthropic.com/v1/messages');
      expect(sent.headers['x-api-key'], 'test-key');
      final body = jsonDecode(sent.body) as Map<String, dynamic>;
      expect(body['model'], 'claude-opus-5-5');
      expect(body['stream'], isTrue);
      expect(body['fallbacks'], 'default');
      final system = body['system'] as List;
      // Catalog block is cached and does not contain per-user data.
      expect(system.first['cache_control'], {'type': 'ephemeral'});
      expect(system.first['text'], contains('Koshari'));
      expect(system.first['text'], isNot(contains('Ahmed')));
      expect(system.last['text'], contains('Ahmed'));
      expect(body['messages'], [
        {'role': 'user', 'content': 'إزاي أعمل كشري؟'},
      ]);
      expect(body['tools'], [
        {'type': 'web_search_20260209', 'name': 'web_search', 'max_uses': 3},
      ]);
      // Prompt tells it to understand Arabic, English and Franco-Arabic.
      expect(system.first['text'], contains('Franco-Arabic'));
    });

    test(
      'web search: reports searching, resumes pause_turn, cites sources',
      () async {
        final bodies = <Map<String, dynamic>>[];
        const url = 'https://www.example.com/fesikh';
        final client = MockClient((request) async {
          bodies.add(jsonDecode(request.body) as Map<String, dynamic>);
          final first = bodies.length == 1;
          return http.Response(
            _sse(
              first
                  ? [
                      {
                        'type': 'content_block_start',
                        'index': 0,
                        'content_block': {
                          'type': 'server_tool_use',
                          'id': 'srvtoolu_1',
                          'name': 'web_search',
                          'input': {},
                        },
                      },
                      {
                        'type': 'content_block_delta',
                        'index': 0,
                        'delta': {
                          'type': 'input_json_delta',
                          'partial_json': '{"query": "فسيخ"}',
                        },
                      },
                      {'type': 'content_block_stop', 'index': 0},
                      {
                        'type': 'message_delta',
                        'delta': {'stop_reason': 'pause_turn'},
                      },
                    ]
                  : [
                      {
                        'type': 'content_block_start',
                        'index': 0,
                        'content_block': {'type': 'text', 'text': ''},
                      },
                      _text('الفسيخ سمك بوري متملح'),
                      {
                        'type': 'content_block_delta',
                        'index': 0,
                        'delta': {
                          'type': 'citations_delta',
                          'citation': {
                            'type': 'web_search_result_location',
                            'url': url,
                            'title': 'Fesikh',
                            'cited_text': '...',
                          },
                        },
                      },
                      {'type': 'content_block_stop', 'index': 0},
                      {
                        'type': 'message_delta',
                        'delta': {'stop_reason': 'end_turn'},
                      },
                    ],
            ),
            200,
            headers: {'content-type': 'text/event-stream; charset=utf-8'},
          );
        });

        final events = await build(
          client,
        ).reply(history: question, context: ctx).toList();

        expect(
          events.whereType<SearchingWeb>().map((e) => e.query),
          contains('فسيخ'),
        );
        expect(events.whereType<TextChunk>().single.text, contains('الفسيخ'));
        final sources = events.whereType<SourcesFound>().single.sources;
        expect(sources.single.url, url);
        expect(sources.single.site, 'example.com');

        // The paused turn is sent back as-is so the server can resume it.
        expect(bodies, hasLength(2));
        final resumed = bodies.last['messages'] as List;
        expect(resumed.last['role'], 'assistant');
        expect(resumed.last['content'], [
          {
            'type': 'server_tool_use',
            'id': 'srvtoolu_1',
            'name': 'web_search',
            'input': {'query': 'فسيخ'},
          },
        ]);
      },
    );

    test('refusal and API errors surface as AssistantException', () async {
      final refusal = build(
        MockClient(
          (_) async => http.Response(
            _sse([
              _text('partial'),
              {
                'type': 'message_delta',
                'delta': {'stop_reason': 'refusal'},
              },
            ]),
            200,
          ),
        ),
      );
      await expectLater(
        refusal.reply(history: question, context: ctx).drain<void>(),
        throwsA(
          isA<AssistantException>().having(
            (e) => e.kind,
            'kind',
            AssistantErrorKind.refusal,
          ),
        ),
      );

      final apiError = build(
        MockClient(
          (_) async => http.Response(
            '{"type":"error","error":{"type":"authentication_error",'
            '"message":"invalid x-api-key"}}',
            401,
          ),
        ),
      );
      await expectLater(
        apiError.reply(history: question, context: ctx).drain<void>(),
        throwsA(
          isA<AssistantException>().having(
            (e) => e.detail,
            'detail',
            contains('invalid x-api-key'),
          ),
        ),
      );
    });

    test('without a key it is not configured', () {
      final a = ClaudeChefAssistant(recipes: repo.all, apiKey: '');
      expect(a.isConfigured, isFalse);
    });
  });

  group('ChatController', () {
    test('streams a reply into the last message', () async {
      final fake = FakeAssistant(answer: 'one two');
      final c = ChatController(fake);
      c.send('hi', ctx);
      expect(c.isReplying, isTrue);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(c.isReplying, isFalse);
      expect(c.messages.last.text.trim(), 'one two');

      c.send('again', ctx);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      // History alternates and includes the earlier turn.
      final history = fake.requests.last.$1;
      expect(history.map((m) => m.role), [
        ChatRole.user,
        ChatRole.assistant,
        ChatRole.user,
      ]);
      c.dispose();
    });

    test('failed turns are not sent back to the model', () async {
      final fake = FakeAssistant()
        ..failWith = const AssistantException(AssistantErrorKind.network);
      final c = ChatController(fake);
      c.send('first', ctx);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(c.messages.last.isError, isTrue);

      fake.failWith = null;
      c.send('second', ctx);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(fake.requests.last.$1.map((m) => m.text), ['second']);
      c.dispose();
    });
  });

  testWidgets('Chef AI tab answers a suggested question', (tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final l = AppLocalizationsAr();
    final fake = FakeAssistant(
      answer: 'انقع الرز ٢٠ دقيقة',
      sources: const [
        WebSource(title: 'رز مفلفل', url: 'https://www.example.com/rice'),
      ],
    );

    await tester.pumpWidget(
      RecipeApp(initialLocale: const Locale('ar'), assistant: fake),
    );
    await tester.tap(find.text(l.tellMeMore));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l.iAmReady));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l.levelBeginner));
    await tester.enterText(find.byType(TextField), 'أحمد');
    await tester.pump();
    await tester.tap(find.text(l.letsGo));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l.assistant).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l.suggestGeneral3));
    await tester.pump(const Duration(milliseconds: 5));
    expect(find.text(l.assistantSearching), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.text(l.suggestGeneral3), findsOneWidget); // now a bubble
    expect(find.text(l.assistantSearching), findsNothing);
    expect(find.textContaining('انقع الرز'), findsOneWidget);
    expect(find.text(l.sources), findsOneWidget);
    expect(find.textContaining('example.com'), findsOneWidget);
    expect(fake.requests.single.$2.userName, 'أحمد');
    expect(fake.requests.single.$2.languageCode, 'ar');
  });
}
