import 'package:flutter/foundation.dart';

import '../data/models/diet_type.dart';
import '../data/models/localized_text.dart';
import '../data/models/recipe.dart';

/// Immutable search/filter criteria for the recipe list.
///
/// Held as ephemeral state by the Explore screen; the filtered list is
/// inferred from it via [apply].
@immutable
class RecipeFilter {
  const RecipeFilter({this.query = '', this.diet, this.tags = const {}});

  final String query;

  /// Null means "any diet".
  final DietType? diet;

  /// Recipe must contain all of these tags.
  final Set<LocalizedText> tags;

  /// Number of active filters, excluding the search query.
  int get activeCount => (diet == null ? 0 : 1) + tags.length;

  RecipeFilter copyWith({
    String? query,
    DietType? Function()? diet,
    Set<LocalizedText>? tags,
  }) => RecipeFilter(
    query: query ?? this.query,
    diet: diet != null ? diet() : this.diet,
    tags: tags ?? this.tags,
  );

  bool matches(Recipe r) =>
      r.matchesQuery(query) &&
      (diet == null || r.diet == diet) &&
      tags.every(r.tags.contains);

  List<Recipe> apply(List<Recipe> recipes) => recipes.where(matches).toList();
}
