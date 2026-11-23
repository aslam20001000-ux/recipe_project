import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../l10n/l10n_labels.dart';

/// Live timeline of the whole challenge.
///
/// Each step is a segment sized by its expected time. Finished steps are
/// fully filled with the color of how they went, the current step fills up
/// as time passes, and upcoming ones stay empty.
class ChallengeTimeline extends StatelessWidget {
  const ChallengeTimeline({
    super.key,
    required this.expected,
    required this.elapsedForStep,
    required this.currentIndex,
    required this.totalElapsed,
    required this.totalExpected,
  });

  final List<Duration> expected;
  final Duration Function(int index) elapsedForStep;
  final int currentIndex;
  final Duration totalElapsed;
  final Duration totalExpected;

  @override
  Widget build(BuildContext context) {
    final totalRatio = totalExpected == Duration.zero
        ? 0.0
        : totalElapsed.inMilliseconds / totalExpected.inMilliseconds;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.timeline, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(context.l10n.timeline, style: AppText.title),
              ),
              Text(
                '${formatClock(totalElapsed)} / ${formatClock(totalExpected)}',
                style: AppText.caption.copyWith(
                  color: timeStatusColor(totalRatio),
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < expected.length; i++)
                Expanded(
                  flex: math.max(1, expected[i].inSeconds),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: i == expected.length - 1 ? 0 : 4,
                    ),
                    child: _Segment(
                      index: i,
                      expected: expected[i],
                      elapsed: elapsedForStep(i),
                      isCurrent: i == currentIndex,
                      isDone: i < currentIndex,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.index,
    required this.expected,
    required this.elapsed,
    required this.isCurrent,
    required this.isDone,
  });

  final int index;
  final Duration expected;
  final Duration elapsed;
  final bool isCurrent;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    final ratio = expected == Duration.zero
        ? 0.0
        : elapsed.inMilliseconds / expected.inMilliseconds;
    final fill = isDone ? 1.0 : ratio.clamp(0.0, 1.0);
    final color = timeStatusColor(ratio);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh,
            borderRadius: BorderRadius.circular(5),
            border: isCurrent
                ? Border.all(color: AppColors.textSecondary, width: 1)
                : null,
          ),
          child: FractionallySizedBox(
            alignment: AlignmentDirectional.centerStart,
            widthFactor: fill,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'S${index + 1}',
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: AppText.caption.copyWith(
            fontSize: 11,
            color: isCurrent ? AppColors.textPrimary : AppColors.textMuted,
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
