import 'package:flutter/material.dart';

import '../data/models/recipe.dart';
import 'screens/assistant/assistant_screen.dart';
import 'screens/challenge/challenge_screen.dart';
import 'screens/recipe_details/recipe_details_screen.dart';

/// Central place for pushing app routes.
abstract final class AppNavigator {
  static Future<void> openRecipe(BuildContext context, Recipe recipe) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => RecipeDetailsScreen(recipe: recipe)),
      );

  static Future<void> askAboutRecipe(BuildContext context, Recipe recipe) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AssistantScreen(recipe: recipe)),
      );

  static Future<void> startChallenge(BuildContext context, Recipe recipe) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => ChallengeScreen(recipe: recipe),
        ),
      );
}
