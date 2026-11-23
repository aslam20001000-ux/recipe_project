import '../data/models/cook_level.dart';
import '../data/models/recipe.dart';

/// Turns the recipe pool into compact text the assistant can read.
///
/// The output depends only on the data (never on the user, time or locale),
/// so the system prompt that contains it stays byte-identical between
/// requests and can be served from the prompt cache.
String buildRecipeCatalog(List<Recipe> recipes) {
  final b = StringBuffer();
  for (final r in recipes) {
    final minutes = r.totalDurationFor(CookLevel.intermediate).inMinutes;
    b
      ..writeln('## ${r.name.en} / ${r.name.ar} (id: ${r.id})')
      ..writeln(
        'Diet: ${r.diet.name} | Serves ${r.servings} | ~$minutes min '
        '(intermediate) | Tags: ${r.tags.map((t) => t.en).join(', ')}',
      )
      ..writeln(r.description.en)
      ..writeln(
        'Ingredients: '
        '${r.ingredients.map((i) => '${i.quantity.en} ${i.name.en}').join('; ')}',
      )
      ..writeln('Steps:');
    for (var i = 0; i < r.steps.length; i++) {
      final s = r.steps[i];
      b.writeln(
        '${i + 1}. ${s.title.en} (${s.baseDuration.inMinutes} min): '
        '${s.description.en}',
      );
    }
    b.writeln();
  }
  return b.toString();
}
