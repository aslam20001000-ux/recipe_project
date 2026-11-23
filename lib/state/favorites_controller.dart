import 'package:flutter/foundation.dart';

import '../data/models/recipe.dart';

/// Shared state: the ids of the recipes the user marked as favorite.
class FavoritesController extends ChangeNotifier {
  final Set<String> _ids = {};

  Set<String> get ids => Set.unmodifiable(_ids);

  bool isFavorite(Recipe recipe) => _ids.contains(recipe.id);

  void toggle(Recipe recipe) {
    if (!_ids.remove(recipe.id)) _ids.add(recipe.id);
    notifyListeners();
  }

  /// Inferred state: filters [all] down to the favorites, keeping order.
  List<Recipe> favoritesFrom(List<Recipe> all) =>
      all.where((r) => _ids.contains(r.id)).toList();
}
