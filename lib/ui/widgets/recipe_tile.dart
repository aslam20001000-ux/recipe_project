import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/recipe.dart';
import '../../l10n/l10n_labels.dart';
import 'diet_badge.dart';
import 'favorite_button.dart';
import 'recipe_image.dart';
import 'recipe_meta.dart';
import 'tag_chip.dart';

/// Horizontal recipe tile used in list view: image, name, tags, time, steps,
/// diet badge and a favorite button.
class RecipeTile extends StatelessWidget {
  const RecipeTile({super.key, required this.recipe, required this.onTap});

  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => _CardShell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox.square(
            dimension: 92,
            child: RecipeImage(
              recipe.imageUrl,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.tr(recipe.name),
                        style: AppText.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    FavoriteButton(recipe, size: 18),
                  ],
                ),
                SizedBox(
                  height: 22,
                  child: ClipRect(child: TagList(recipe.tags)),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(child: RecipeMeta(recipe)),
                    DietBadge(recipe.diet),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// Vertical recipe card used in grid view.
class RecipeGridCard extends StatelessWidget {
  const RecipeGridCard({super.key, required this.recipe, required this.onTap});

  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => _CardShell(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              RecipeImage(
                recipe.imageUrl,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
              PositionedDirectional(
                top: 6,
                end: 6,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                  ),
                  child: FavoriteButton(recipe, size: 18),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr(recipe.name),
                style: AppText.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 22,
                child: ClipRect(child: TagList(recipe.tags)),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: RecipeMeta(recipe)),
                  DietBadge(recipe.diet),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: AppColors.border),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(onTap: onTap, child: child),
  );
}
