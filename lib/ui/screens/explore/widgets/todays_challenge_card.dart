import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/recipe.dart';
import '../../../../l10n/l10n_labels.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/recipe_image.dart';
import '../../../widgets/recipe_meta.dart';
import '../../../widgets/tag_chip.dart';

/// Featured card for the recipe flagged as today's challenge.
class TodaysChallengeCard extends StatelessWidget {
  const TodaysChallengeCard({
    super.key,
    required this.recipe,
    required this.onOpen,
    required this.onStart,
  });

  final Recipe recipe;
  final VoidCallback onOpen;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(minHeight: 210),
    child: Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onOpen,
        child: Stack(
          children: [
            // Image at the end side, fading into the card towards the start.
            Positioned.fill(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  heightFactor: 1,
                  child: RecipeImage(recipe.imageUrl),
                ),
              ),
            ),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.centerStart,
                    end: AlignmentDirectional.centerEnd,
                    stops: [0.35, 0.75],
                    colors: [AppColors.surface, Colors.transparent],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.military_tech_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        context.l10n.todaysChallenge,
                        style: AppText.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  FractionallySizedBox(
                    widthFactor: 0.65,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      context.tr(recipe.name),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.heading.copyWith(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TagList(recipe.tags, translucent: true),
                  const SizedBox(height: 24),
                  RecipeMeta(recipe),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    label: context.l10n.startChallenge,
                    onPressed: onStart,
                    expand: false,
                    compact: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
