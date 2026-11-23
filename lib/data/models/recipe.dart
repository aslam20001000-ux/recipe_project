import 'package:flutter/foundation.dart';

import 'cook_level.dart';
import 'diet_type.dart';
import 'ingredient.dart';
import 'localized_text.dart';
import 'recipe_step.dart';

/// Immutable description of a recipe.
///
/// Everything here is pure data. Values that depend on the user (such as the
/// expected total time for their cook level) are derived through methods
/// instead of being stored.
@immutable
class Recipe {
  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.diet,
    required this.servings,
    required this.ingredients,
    required this.steps,
    this.isTodaysChallenge = false,
  });

  final String id;
  final LocalizedText name;
  final LocalizedText description;
  final String imageUrl;

  /// Tags; the English text doubles as the stable filter key.
  final List<LocalizedText> tags;
  final DietType diet;
  final int servings;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  /// Marks the recipe that is featured as "Today's Challenge".
  final bool isTodaysChallenge;

  int get stepCount => steps.length;

  /// Expected total time for the whole recipe at the given cook level.
  Duration totalDurationFor(CookLevel level) => steps.fold(
    Duration.zero,
    (total, step) => total + step.durationFor(level),
  );

  bool matchesQuery(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return name.contains(q) ||
        tags.any((tag) => tag.contains(q)) ||
        ingredients.any((i) => i.name.contains(q));
  }

  @override
  bool operator ==(Object other) => other is Recipe && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
