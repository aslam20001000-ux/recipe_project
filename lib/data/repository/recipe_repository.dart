import 'dart:math';

import '../models/localized_text.dart';
import '../models/recipe.dart';
import 'recipes_data.dart';

/// Read-only access to the recipe data pool.
class RecipeRepository {
  RecipeRepository({List<Recipe> recipes = recipesData, Random? random})
    : _recipes = List.unmodifiable(recipes),
      _random = random ?? Random();

  final List<Recipe> _recipes;
  final Random _random;

  List<Recipe> get all => _recipes;

  /// All distinct tags in the data pool, Egyptian first, then A–Z.
  List<LocalizedText> get allTags =>
      {for (final r in _recipes) ...r.tags}.toList()..sort(
        (a, b) => a.en == 'Egyptian'
            ? -1
            : b.en == 'Egyptian'
            ? 1
            : a.en.compareTo(b.en),
      );

  /// The recipe flagged as today's challenge, searched dynamically.
  /// Falls back to the first recipe if none is flagged.
  Recipe? get todaysChallenge {
    if (_recipes.isEmpty) return null;
    return _recipes.firstWhere(
      (r) => r.isTodaysChallenge,
      orElse: () => _recipes.first,
    );
  }

  Recipe randomRecipe() => _recipes[_random.nextInt(_recipes.length)];

  Recipe? byId(String id) {
    for (final r in _recipes) {
      if (r.id == id) return r;
    }
    return null;
  }
}
