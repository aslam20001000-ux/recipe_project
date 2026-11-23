import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/recipe.dart';
import '../../l10n/l10n_labels.dart';
import '../../state/favorites_controller.dart';

/// Heart toggle bound to the shared [FavoritesController].
class FavoriteButton extends StatelessWidget {
  const FavoriteButton(this.recipe, {super.key, this.size = 20});

  final Recipe recipe;
  final double size;

  @override
  Widget build(BuildContext context) {
    final isFav = context.select(
      (FavoritesController f) => f.isFavorite(recipe),
    );
    return IconButton(
      visualDensity: VisualDensity.compact,
      tooltip: isFav
          ? context.l10n.removeFromFavorites
          : context.l10n.addToFavorites,
      onPressed: () => context.read<FavoritesController>().toggle(recipe),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFav),
          size: size,
          color: isFav ? AppColors.favorite : AppColors.textSecondary,
        ),
      ),
    );
  }
}
