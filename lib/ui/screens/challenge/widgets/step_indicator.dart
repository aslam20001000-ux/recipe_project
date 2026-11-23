import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/l10n_labels.dart';

/// "Step 2 of 4" with a segmented bar.
class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key, required this.current, required this.total});

  /// Zero-based index of the current step.
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text.rich(
        TextSpan(
          style: AppText.title,
          children: [
            TextSpan(text: context.l10n.stepWord),
            TextSpan(
              text: '${current + 1}',
              style: const TextStyle(color: AppColors.primary),
            ),
            TextSpan(
              text: context.l10n.ofTotal(total),
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          for (var i = 0; i < total; i++)
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 5,
                margin: EdgeInsetsDirectional.only(end: i == total - 1 ? 0 : 4),
                decoration: BoxDecoration(
                  color: i <= current
                      ? AppColors.primary
                      : AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
        ],
      ),
    ],
  );
}
