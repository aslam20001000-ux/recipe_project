import 'package:flutter/material.dart';

import '../../data/models/recipe.dart';
import 'recipe_tile.dart';

enum RecipeViewMode { list, grid }

/// Sliver that lays out recipes as an adaptive list or grid.
///
/// In list mode tiles flow into multiple columns on wide windows, so the
/// same widget works from phone to desktop.
class RecipeCollectionSliver extends StatelessWidget {
  const RecipeCollectionSliver({
    super.key,
    required this.recipes,
    required this.onTap,
    this.mode = RecipeViewMode.list,
  });

  final List<Recipe> recipes;
  final ValueChanged<Recipe> onTap;
  final RecipeViewMode mode;

  @override
  Widget build(BuildContext context) {
    final isList = mode == RecipeViewMode.list;
    return SliverGrid.builder(
      itemCount: recipes.length,
      gridDelegate: isList
          ? const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 560,
              mainAxisExtent: 124,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            )
          : const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 260,
              mainAxisExtent: 250,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
      itemBuilder: (context, i) {
        final recipe = recipes[i];
        return isList
            ? RecipeTile(recipe: recipe, onTap: () => onTap(recipe))
            : RecipeGridCard(recipe: recipe, onTap: () => onTap(recipe));
      },
    );
  }
}
