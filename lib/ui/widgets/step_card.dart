import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/l10n_labels.dart';
import '../../data/models/recipe_step.dart';

/// Card describing one recipe step. Used in the details Steps tab and in the
/// challenge (current step, and faded for the upcoming one).
class StepCard extends StatelessWidget {
  const StepCard({
    super.key,
    required this.step,
    required this.number,
    required this.expected,
    this.highlighted = false,
    this.large = false,
    this.label,
  });

  final RecipeStep step;
  final int number;
  final Duration expected;
  final bool highlighted;
  final bool large;

  /// Optional caption above the title, e.g. "Up next".
  final String? label;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(large ? 20 : 14),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: highlighted ? AppColors.primary : AppColors.border,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: large ? 40 : 30,
          height: large ? 40 : 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: highlighted
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$number',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: large ? 16 : 13,
              color: highlighted ? Colors.white : AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null) ...[
                Text(
                  label!,
                  style: AppText.caption.copyWith(
                    letterSpacing: 1,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                context.tr(step.title),
                style: large
                    ? AppText.heading.copyWith(fontSize: 20)
                    : AppText.title,
              ),
              SizedBox(height: large ? 10 : 6),
              Text(
                context.tr(step.description),
                style: AppText.body.copyWith(fontSize: large ? 15 : 13),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    formatMinutes(expected, context.l10n),
                    style: AppText.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
