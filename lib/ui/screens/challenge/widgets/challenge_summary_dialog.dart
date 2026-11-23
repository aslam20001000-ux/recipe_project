import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../data/models/challenge_result.dart';
import '../../../../l10n/l10n_labels.dart';
import '../../../widgets/primary_button.dart';

Future<void> showChallengeSummary(
  BuildContext context,
  ChallengeResult result,
) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => _SummaryDialog(result: result),
);

class _SummaryDialog extends StatelessWidget {
  const _SummaryDialog({required this.result});

  final ChallengeResult result;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final won = result.beatTheClock;
    final color = won ? AppColors.success : AppColors.danger;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                won ? Icons.emoji_events : Icons.timer_off_outlined,
                size: 56,
                color: won ? AppColors.warning : AppColors.textSecondary,
              ),
              const SizedBox(height: 12),
              Text(
                won ? l.youBeatTheClock : l.challengeComplete,
                style: AppText.heading,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(context.tr(result.recipeName), style: AppText.body),
              const SizedBox(height: 20),
              Row(
                children: [
                  _Figure(l.yourTime, formatClock(result.actualTotal), color),
                  _Figure(
                    l.expected,
                    formatClock(result.expectedTotal),
                    AppColors.textPrimary,
                  ),
                  _Figure(
                    l.onTime,
                    '${result.stepsOnTime}/${result.actualStepTimes.length}',
                    AppColors.textPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: l.done,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure(this.label, this.value, this.color);

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(value, style: AppText.title.copyWith(fontSize: 18, color: color)),
        const SizedBox(height: 4),
        Text(label, style: AppText.caption),
      ],
    ),
  );
}
