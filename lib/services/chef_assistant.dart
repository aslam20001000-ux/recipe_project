import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../data/models/chat_message.dart';
import '../data/models/cook_level.dart';
import '../data/models/recipe.dart';
import 'assistant_events.dart';
import 'recipe_catalog.dart';
import 'sse_turn.dart';

export 'assistant_events.dart';

/// Who is asking and what they are looking at. Sent after the cached part
/// of the prompt, because it changes per user and per screen.
@immutable
class AssistantContext {
  const AssistantContext({
    required this.userName,
    required this.level,
    required this.languageCode,
    this.recipe,
  });

  final String userName;
  final CookLevel level;
  final String languageCode;

  /// Recipe the user opened the chat from, if any.
  final Recipe? recipe;
}

/// Error shown to the user when a reply cannot be produced.
class AssistantException implements Exception {
  const AssistantException(this.kind, [this.detail]);

  final AssistantErrorKind kind;
  final String? detail;

  @override
  String toString() => 'AssistantException($kind, $detail)';
}

enum AssistantErrorKind { notConfigured, network, api, refusal }

/// Answers cooking questions. The UI depends on this interface so tests
/// can swap in a fake.
abstract interface class ChefAssistant {
  bool get isConfigured;

  /// Streams the reply as it is generated: text, web searches, sources.
  Stream<AssistantEvent> reply({
    required List<ChatMessage> history,
    required AssistantContext context,
  });
}

/// [ChefAssistant] backed by the Claude Messages API (raw HTTP + SSE
/// streaming, since Dart has no official Anthropic SDK), with Anthropic's
/// server-side web search for anything the app's recipes don't cover.
///
/// The key comes from `--dart-define=ANTHROPIC_API_KEY=...`. A key built into
/// an app can be extracted by anyone who has the app, so for a public release
/// point [baseUrl] (`--dart-define=ANTHROPIC_BASE_URL=...`) at your own
/// backend that adds the key server-side.
class ClaudeChefAssistant implements ChefAssistant {
  ClaudeChefAssistant({
    required List<Recipe> recipes,
    String? apiKey,
    String? baseUrl,
    http.Client Function()? clientFactory,
  }) : _apiKey = apiKey ?? const String.fromEnvironment('ANTHROPIC_API_KEY'),
       _baseUrl =
           baseUrl ??
           const String.fromEnvironment(
             'ANTHROPIC_BASE_URL',
             defaultValue: 'https://api.anthropic.com',
           ),
       _clientFactory = clientFactory ?? http.Client.new,
       _systemPrompt = _instructions + buildRecipeCatalog(recipes);

  static const model = 'claude-opus-5-5';

  /// How many times a paused search turn is resumed before giving up.
  static const maxContinuations = 3;

  final String _apiKey;
  final String _baseUrl;
  final http.Client Function() _clientFactory;
  final String _systemPrompt;

  static const _instructions = '''
You are "Chef AI", the friendly cooking assistant inside a recipe-challenge app.
Answer any cooking question: how to cook a dish, ingredients, substitutions,
quantities, timing, techniques, storage, nutrition and troubleshooting.
Questions can be about any dish in the world, not only the ones in the app.

Understanding the user:
- Users write in Arabic (often Egyptian dialect), English, a mix of both, or
  Arabic in Latin letters (Franco-Arabic, e.g. "koshary", "7awawshi",
  "mahshy"). Match dish names across languages and spellings: "كشري",
  "koshari" and "koshary" are the same dish.
- Reply in the language of the user's latest message. Arabic or
  Franco-Arabic gets friendly Egyptian Arabic in Arabic script; English gets
  English.

Where answers come from:
- If the dish is in the app's catalog below, answer from the catalog and say
  they can open it in the app.
- If the dish or the fact is not in the catalog, use web search before
  answering, so the answer is correct rather than guessed. Search in the
  language most likely to give good results (Arabic for Egyptian and Arab
  dishes), and prefer recipe sites and reliable food sources.
- Plain cooking basics you are sure of (boiling an egg, keeping rice from
  sticking) need no search.
- If sources disagree, give the common version and mention the difference
  in one line. Never invent a dish: if nothing reliable is found, say so.

Style:
- Get straight to the answer and keep it short: a few lines, or a short list
  for ingredients and steps. Go longer only when asked for a full recipe.
- Plain text only: the chat cannot render Markdown, so no #, **, tables,
  links or code blocks. Use "•" or "1." at the start of a line for lists.
  The app lists the web sources under your answer, so don't write URLs.
- Scale timings to the user's cook level when it matters.
- If the question is not about food or cooking, say briefly that you only
  help with cooking.

App recipe catalog (times are for an intermediate cook):

''';

  @override
  bool get isConfigured => _apiKey.isNotEmpty;

  String _contextText(AssistantContext ctx) {
    final r = ctx.recipe;
    final b = StringBuffer()
      ..writeln('User name: ${ctx.userName.isEmpty ? 'unknown' : ctx.userName}')
      ..writeln(
        'Cook level: ${ctx.level.name} '
        '(step times x${ctx.level.timeFactor} of intermediate)',
      )
      ..writeln('App language: ${ctx.languageCode}');
    if (r != null) {
      b.writeln(
        'The user opened the chat from the recipe "${r.name.en}" / '
        '"${r.name.ar}" (id: ${r.id}); "this dish" means that recipe.',
      );
    }
    return b.toString();
  }

  Map<String, dynamic> _body(
    List<Map<String, dynamic>> messages,
    AssistantContext ctx,
  ) => {
    'model': model,
    'max_tokens': 16000,
    'stream': true,
    // Short chat answers: low effort keeps replies fast.
    'output_config': {'effort': 'low'},
    // If a safety classifier declines, the API retries on a fallback model.
    'fallbacks': 'default',
    'tools': [
      // Runs on Anthropic's servers; results come back in the same stream.
      {'type': 'web_search_20260209', 'name': 'web_search', 'max_uses': 3},
    ],
    'system': [
      {
        'type': 'text',
        'text': _systemPrompt,
        'cache_control': {'type': 'ephemeral'},
      },
      {'type': 'text', 'text': _contextText(ctx)},
    ],
    'messages': messages,
  };

  @override
  Stream<AssistantEvent> reply({
    required List<ChatMessage> history,
    required AssistantContext context,
  }) async* {
    if (!isConfigured) {
      throw const AssistantException(AssistantErrorKind.notConfigured);
    }

    final messages = <Map<String, dynamic>>[
      for (final m in history)
        {'role': m.isUser ? 'user' : 'assistant', 'content': m.text},
    ];
    final sources = <String, WebSource>{};

    for (var round = 0; round <= maxContinuations; round++) {
      final turn = SseTurn();
      yield* _streamTurn(_body(messages, context), turn);
      for (final s in turn.sources) {
        sources[s.url] = s;
      }

      // The server-side search loop hit its step limit: send the partial
      // assistant turn back unchanged and the API carries on from there.
      if (turn.stopReason != 'pause_turn') break;
      if (messages.last['role'] == 'assistant') {
        (messages.last['content'] as List).addAll(turn.content);
      } else {
        messages.add({'role': 'assistant', 'content': turn.content});
      }
    }

    if (sources.isNotEmpty) {
      yield SourcesFound(sources.values.take(4).toList());
    }
  }

  Stream<AssistantEvent> _streamTurn(
    Map<String, dynamic> body,
    SseTurn turn,
  ) async* {
    final client = _clientFactory();
    try {
      final request = http.Request('POST', Uri.parse('$_baseUrl/v1/messages'))
        ..headers.addAll({
          'content-type': 'application/json',
          'x-api-key': _apiKey,
          'anthropic-version': '2026-10-21',
          'anthropic-beta': 'server-side-fallback-2026-07-01',
          // Required for calls made straight from a browser (web build).
          if (kIsWeb) 'anthropic-dangerous-direct-browser-access': 'true',
        })
        ..body = jsonEncode(body);

      final http.StreamedResponse response;
      try {
        response = await client.send(request);
      } on Exception catch (e) {
        throw AssistantException(AssistantErrorKind.network, '$e');
      }

      if (response.statusCode != 200) {
        final text = await response.stream.bytesToString();
        throw AssistantException(
          AssistantErrorKind.api,
          '${response.statusCode}: ${_errorMessage(text)}',
        );
      }

      final lines = response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());
      await for (final line in lines) {
        if (!line.startsWith('data:')) continue;
        final event = jsonDecode(line.substring(5).trim());
        if (event is! Map<String, dynamic>) continue;
        final index = event['index'];

        switch (event['type']) {
          case 'content_block_start':
            final block = event['content_block'] as Map<String, dynamic>;
            turn.start(index as int, block);
            if (block['type'] == 'server_tool_use') {
              yield const SearchingWeb(null); // query arrives at block stop
            }
          case 'content_block_delta':
            final delta = event['delta'] as Map<String, dynamic>;
            turn.delta(index as int, delta);
            // Only visible text reaches the chat; thinking, search results
            // and fallback markers stay in the turn.
            if (delta['type'] == 'text_delta') {
              yield TextChunk(delta['text'] as String);
            }
          case 'content_block_stop':
            final block = turn.stop(index as int);
            if (block?['type'] == 'server_tool_use' &&
                block?['name'] == 'web_search') {
              final input = block!['input'];
              yield SearchingWeb(
                input is Map ? input['query'] as String? : null,
              );
            }
          case 'message_delta':
            final delta = event['delta'];
            final stop = delta is Map ? delta['stop_reason'] : null;
            if (stop == 'refusal') {
              throw const AssistantException(AssistantErrorKind.refusal);
            }
            if (stop is String) turn.stopReason = stop;
          case 'error':
            final error = event['error'];
            throw AssistantException(
              AssistantErrorKind.api,
              error is Map ? '${error['message']}' : '$error',
            );
        }
      }
    } finally {
      client.close();
    }
  }

  static String _errorMessage(String body) {
    try {
      final json = jsonDecode(body);
      final error = json is Map ? json['error'] : null;
      final message = error is Map ? error['message'] : null;
      if (message is String) return message;
    } on FormatException {
      // Not JSON; fall through to the raw body.
    }
    return body;
  }
}
