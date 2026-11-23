import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../l10n/l10n_labels.dart';

/// Current time / expected time. The color shifts from green to red the more
/// the counter exceeds the expected time.
class TimeCounter extends StatelessWidget {
  const TimeCounter({
    super.key,
    required this.elapsed,
    required this.expected,
    this.size = 200,
  });

  final Duration elapsed;
  final Duration expected;
  final double size;

  double get _ratio => expected == Duration.zero
      ? 0
      : elapsed.inMilliseconds / expected.inMilliseconds;

  String _status(AppLocalizations l) {
    final r = _ratio;
    if (r <= 0.75) return l.statusOnTrack;
    if (r <= 1) return l.statusAlmost;
    if (r <= 1.25) return l.statusBitOver;
    if (r <= 1.5) return l.statusLate;
    return l.statusWayOver;
  }

  @override
  Widget build(BuildContext context) {
    final color = timeStatusColor(_ratio);
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(end: color),
              duration: const Duration(milliseconds: 400),
              builder: (context, c, _) => CircularProgressIndicator(
                value: _ratio.clamp(0.0, 1.0),
                strokeWidth: 8,
                strokeCap: StrokeCap.round,
                backgroundColor: AppColors.surfaceHigh,
                color: c,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.currentTime, style: AppText.caption),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 400),
                style: TextStyle(
                  fontSize: size * 0.2,
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
                child: Text(formatClock(elapsed)),
              ),
              Text(
                '/ ${formatClock(expected)}',
                style: AppText.body.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _status(context.l10n),
                style: AppText.caption.copyWith(color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
