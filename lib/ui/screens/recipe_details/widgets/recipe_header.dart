import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/recipe.dart';
import '../../../../l10n/l10n_labels.dart';
import '../../../widgets/diet_badge.dart';
import '../../../widgets/recipe_image.dart';
import '../../../widgets/tag_chip.dart';

/// Recipe image with an overlaid gradient and the title brief (title, tags,
/// diet) stacked near the bottom.
class RecipeHeader extends StatelessWidget {
  const RecipeHeader({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      RecipeImage(recipe.imageUrl),
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.3, 0.6, 1],
            colors: [
              Color(0x99000000),
              Colors.transparent,
              Color(0x99111318),
              AppColors.background,
            ],
          ),
        ),
      ),
      PositionedDirectional(
        start: 20,
        end: 20,
        bottom: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.tr(recipe.name), style: AppText.display),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: TagList(recipe.tags, translucent: true)),
                DietBadge(recipe.diet, showLabel: true),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
