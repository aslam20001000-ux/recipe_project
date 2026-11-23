import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/l10n_labels.dart';
import '../../../../data/models/recipe.dart';
import '../../../../state/user_controller.dart';

/// Description, quick stats and ingredients.
class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final level = context.select((UserController u) => u.level);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr(recipe.description), style: AppText.body),
        const SizedBox(height: 20),
        Row(
          children: [
            _Stat(
              icon: Icons.schedule,
              value: formatMinutes(
                recipe.totalDurationFor(level),
                context.l10n,
              ),
              label: context.l10n.forLevel(level.label(context.l10n)),
            ),
            const SizedBox(width: 10),
            _Stat(
              icon: Icons.route_outlined,
              value: '${recipe.stepCount}',
              label: context.l10n.steps,
            ),
            const SizedBox(width: 10),
            _Stat(
              icon: Icons.people_outline,
              value: '${recipe.servings}',
              label: context.l10n.servings,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          context.l10n.ingredientsCount(recipe.ingredients.length),
          style: AppText.heading.copyWith(fontSize: 19),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              for (final (i, ing) in recipe.ingredients.indexed) ...[
                if (i > 0) const Divider(height: 1, indent: 14, endIndent: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 7,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.tr(ing.name),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(context.tr(ing.quantity), style: AppText.caption),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value, required this.label});

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppText.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppText.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
