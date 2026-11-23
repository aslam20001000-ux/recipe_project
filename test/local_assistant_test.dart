import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_project/data/models/chat_message.dart';
import 'package:recipe_project/data/models/cook_level.dart';
import 'package:recipe_project/data/repository/recipe_repository.dart';
import 'package:recipe_project/services/chef_assistant.dart';
import 'package:recipe_project/services/local_chef_assistant.dart';

void main() {
  final a = LocalChefAssistant(recipes: RecipeRepository().all);

  Future<String> ask(List<String> qs, {String lang = 'ar'}) async {
    final history = <ChatMessage>[];
    var out = '';
    for (final q in qs) {
      history.add(ChatMessage(role: ChatRole.user, text: q));
      out = (await a
              .reply(
                history: history,
                context: AssistantContext(
                  userName: 'Islam',
                  level: CookLevel.beginner,
                  languageCode: lang,
                ),
              )
              .map((e) => (e as TextChunk).text)
              .toList())
          .join();
      history.add(ChatMessage(role: ChatRole.assistant, text: out));
    }
    return out;
  }

  test('answers in Arabic with no key', () async {
    final r = await ask(['اعمل مكرونه ازاي']);
    expect(a.isConfigured, isTrue);
    expect(r, contains('المكونات'));
  });

  test('ingredient search, follow-up and English', () async {
    expect(await ask(['عندي فراخ']), contains('فراخ'));
    expect(await ask(['كشري', 'بياخد وقت قد ايه؟']), contains('دقيقة'));
    expect(await ask(['how to make koshari'], lang: 'en'), contains('Koshari'));
    expect(await ask(['xyzzy']), contains('ملقتش'));
  });
}
