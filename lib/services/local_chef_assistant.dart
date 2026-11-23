import 'dart:async';

import '../data/models/chat_message.dart';
import '../data/models/recipe.dart';
import 'chef_assistant.dart';

/// [ChefAssistant] that works fully offline, with no API key: it finds the
/// app recipe that best matches the question (by name, tag or ingredient,
/// in English or Arabic) and answers with its ingredients and steps.
class LocalChefAssistant implements ChefAssistant {
  LocalChefAssistant({required List<Recipe> recipes, this.typingDelay})
    : _recipes = recipes,
      _index = [for (final r in recipes) _RecipeIndex.of(r)];

  final List<Recipe> _recipes;
  final List<_RecipeIndex> _index;

  /// Pause between streamed lines (typing effect). Null = no pause.
  final Duration? typingDelay;

  @override
  bool get isConfigured => true;

  @override
  Stream<AssistantEvent> reply({
    required List<ChatMessage> history,
    required AssistantContext context,
  }) async* {
    final ar = context.languageCode == 'ar';
    final question = history.isEmpty ? '' : history.last.text;
    final text = _answer(question, history, context, ar);
    for (final line in text.split('\n')) {
      if (typingDelay != null) await Future<void>.delayed(typingDelay!);
      yield TextChunk('$line\n');
    }
  }

  String _answer(
    String question,
    List<ChatMessage> history,
    AssistantContext context,
    bool ar,
  ) {
    final tokens = _tokens(question);

    if (tokens.isEmpty && _isGreeting(question)) {
      return ar
          ? 'أهلاً يا ${context.userName}! 👋\n'
                'اسألني عن أي أكلة أو قولي عندك إيه في التلاجة وأنا أقولك تعمل إيه.'
          : 'Hi ${context.userName}! 👋\n'
                'Ask me about any dish, or tell me what you have and I will '
                'suggest something.';
    }

    var ranked = _rank(tokens);

    // Follow-up like "how long does it take?": stay on the current recipe.
    if (ranked.isEmpty) {
      final current = context.recipe ?? _lastDiscussed(history);
      if (current != null) ranked = [current];
    }

    if (ranked.isEmpty) return _notFound(ar);

    final recipe = ranked.first;
    final others = ranked.skip(1).take(3).toList();
    final b = StringBuffer();
    final name = ar ? recipe.name.ar : recipe.name.en;
    final minutes = recipe.totalDurationFor(context.level).inMinutes;
    final asksIngredients = _hasAny(question, _ingredientWords);
    final asksTime = _hasAny(question, _timeWords);

    if (asksTime && !asksIngredients) {
      b.writeln(
        ar
            ? '⏱️ $name بياخد حوالي $minutes دقيقة على مستواك، '
                  'وبيكفي ${recipe.servings} أشخاص.'
            : '⏱️ $name takes about $minutes min at your level and serves '
                  '${recipe.servings}.',
      );
    } else {
      b
        ..writeln('🍽️ **$name**')
        ..writeln(ar ? recipe.description.ar : recipe.description.en)
        ..writeln()
        ..writeln(
          ar
              ? '⏱️ حوالي $minutes دقيقة · 👥 ${recipe.servings} أشخاص'
              : '⏱️ About $minutes min · 👥 Serves ${recipe.servings}',
        )
        ..writeln()
        ..writeln(ar ? '**المكونات:**' : '**Ingredients:**');
      for (final i in recipe.ingredients) {
        b.writeln(
          ar
              ? '• ${i.name.ar}: ${i.quantity.ar}'
              : '• ${i.quantity.en} ${i.name.en}',
        );
      }
      if (!asksIngredients) {
        b
          ..writeln()
          ..writeln(ar ? '**الطريقة:**' : '**Steps:**');
        for (var n = 0; n < recipe.steps.length; n++) {
          final s = recipe.steps[n];
          final m = s.durationFor(context.level).inMinutes;
          b.writeln(
            ar
                ? '${n + 1}. **${s.title.ar}** ($m د): ${s.description.ar}'
                : '${n + 1}. **${s.title.en}** ($m min): ${s.description.en}',
          );
        }
      }
    }

    if (others.isNotEmpty) {
      final names = others.map((r) => ar ? r.name.ar : r.name.en).join('، ');
      b
        ..writeln()
        ..write(ar ? '💡 ممكن كمان تجرب: $names' : '💡 You could also try: $names');
    }
    return b.toString().trimRight();
  }

  /// Recipes matching [tokens], best first.
  List<Recipe> _rank(List<String> tokens) {
    if (tokens.isEmpty) return const [];
    final scored = <(Recipe, int)>[];
    for (var i = 0; i < _recipes.length; i++) {
      final score = _index[i].score(tokens);
      if (score > 0) scored.add((_recipes[i], score));
    }
    scored.sort((a, b) => b.$2.compareTo(a.$2));
    return [for (final s in scored) s.$1];
  }

  Recipe? _lastDiscussed(List<ChatMessage> history) {
    // Skip the current question, then look back through earlier ones.
    for (var i = history.length - 2; i >= 0; i--) {
      if (!history[i].isUser) continue;
      final ranked = _rank(_tokens(history[i].text));
      if (ranked.isNotEmpty) return ranked.first;
    }
    return null;
  }

  String _notFound(bool ar) {
    final picks = [
      ..._recipes.where((r) => r.isTodaysChallenge),
      ..._recipes.where((r) => !r.isTodaysChallenge),
    ].take(4).map((r) => ar ? r.name.ar : r.name.en).join(ar ? '، ' : ', ');
    return ar
        ? 'للأسف ملقتش الأكلة دي في وصفات التطبيق 😅\n'
              'جرب تكتب اسم الأكلة أو مكون عندك (زي: فراخ، رز، مكرونة).\n\n'
              '💡 من الوصفات اللي عندي: $picks'
        : "Sorry, I couldn't find that in the app's recipes 😅\n"
              'Try a dish name or an ingredient you have (e.g. chicken, rice, '
              'pasta).\n\n💡 Some recipes I know: $picks';
  }
}

/// Normalized words of one recipe, for matching.
class _RecipeIndex {
  _RecipeIndex(this.name, this.tags, this.ingredients);

  factory _RecipeIndex.of(Recipe r) => _RecipeIndex(
    {..._words(r.name.en), ..._words(r.name.ar)},
    {for (final t in r.tags) ...{..._words(t.en), ..._words(t.ar)}},
    {
      for (final i in r.ingredients) ...{
        ..._words(i.name.en),
        ..._words(i.name.ar),
      },
    },
  );

  final Set<String> name;
  final Set<String> tags;
  final Set<String> ingredients;

  int score(List<String> tokens) {
    var total = 0;
    for (final t in tokens) {
      if (_matches(t, name)) {
        total += 6;
      } else if (_matches(t, tags)) {
        total += 3;
      } else if (_matches(t, ingredients)) {
        total += 2;
      }
    }
    return total;
  }

  static bool _matches(String token, Set<String> words) {
    for (final w in words) {
      if (w == token) return true;
      if (token.length >= 4 && w.length >= 4) {
        if (w.startsWith(token) || token.startsWith(w)) return true;
      }
    }
    return false;
  }
}

// ───────────────────────────── text helpers ─────────────────────────────

final _diacritics = RegExp('[ً-ْـ]');
final _splitter = RegExp(r'[^a-z0-9ء-ي]+');

/// Lower-cases and unifies Arabic spelling variants (أ/إ/آ → ا, ة → ه, ى → ي).
String _normalize(String s) => s
    .toLowerCase()
    .replaceAll(_diacritics, '')
    .replaceAll(RegExp('[أإآ]'), 'ا')
    .replaceAll('ة', 'ه')
    .replaceAll('ى', 'ي')
    .replaceAll('ؤ', 'و')
    .replaceAll('ئ', 'ي');

/// Strips common Arabic prefixes ("و", "ال", "بال"…) and English plurals.
String _stem(String w) {
  for (final p in const ['وبال', 'وال', 'بال', 'فال', 'كال', 'لل', 'ال']) {
    if (w.startsWith(p) && w.length - p.length >= 2) return w.substring(p.length);
  }
  if (w.startsWith('و') && w.length > 3) return w.substring(1);
  if (RegExp(r'^[a-z]+s$').hasMatch(w) && w.length > 3) {
    return w.substring(0, w.length - 1);
  }
  return w;
}

Set<String> _words(String s) => {
  for (final w in _normalize(s).split(_splitter))
    if (w.length >= 2) _stem(w),
};

List<String> _tokens(String question) => [
  for (final w in _words(question))
    if (!_stopWords.contains(w)) w,
];

bool _hasAny(String question, Set<String> words) {
  final ws = _words(question);
  return ws.any(words.contains);
}

bool _isGreeting(String q) {
  final ws = _normalize(q).split(_splitter).toSet();
  return ws.any(_greetings.contains);
}

final _greetings = {
  'hi', 'hello', 'hey', 'اهلا', 'مرحبا', 'السلام', 'هاي', 'ازيك', 'صباح', 'مساء',
};

final _ingredientWords = {
  for (final w in const [
    'مكونات', 'المكونات', 'محتاج', 'محتاجه', 'ingredients', 'ingredient',
    'need',
  ])
    ..._words(w),
};

final _timeWords = {
  for (final w in const [
    'وقت', 'الوقت', 'دقيقه', 'دقايق', 'ساعه', 'time', 'long', 'minutes',
  ])
    ..._words(w),
};

/// Words that say nothing about which dish is meant.
final _stopWords = {
  for (final w in const [
    // Arabic
    'اعمل', 'اعملها', 'اعمله', 'نعمل', 'عمل', 'ازاي', 'ازاى', 'ازي', 'ايه',
    'اي', 'عايز', 'عاوز', 'عايزه', 'ابغي', 'ابي', 'اريد', 'كيف', 'ممكن',
    'طريقه', 'وصفه', 'اطبخ', 'طبخ', 'اطبخها', 'في', 'من', 'على', 'علي', 'مع',
    'عن', 'هو', 'هي', 'انا', 'انت', 'لو', 'يا', 'شيف', 'حاجه', 'اكله', 'اكل',
    'عندي', 'النهارده', 'دي', 'ده', 'بتاع', 'بتاعه', 'قولي', 'اقترح', 'تقترح',
    'لي', 'ليا', 'بس', 'كام', 'قد', 'مكونات', 'محتاج', 'وقت', 'دقيقه',
    'بياخد', 'تاخد', 'تحضير', 'حضر', 'احضر', 'سهل', 'سهله', 'سريع', 'سريعه',
    // English
    'how', 'to', 'make', 'cook', 'recipe', 'the', 'an', 'want', 'what',
    'is', 'can', 'you', 'me', 'for', 'with', 'of', 'do', 'please', 'have',
    'some', 'give', 'tell', 'about', 'dish', 'food', 'easy', 'quick', 'it',
    'does', 'take', 'ingredients', 'need', 'time', 'long', 'minutes', 'my',
    'today', 'suggest', 'something', 'and', 'or', 'in', 'should',
  ])
    ..._words(w),
};
