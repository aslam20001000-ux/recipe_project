import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// Language-dependent formatters (minutes, greeting, date) live in
// lib/l10n/l10n_labels.dart.

/// Clock style "mm:ss" (or "h:mm:ss" past an hour).
String formatClock(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return h > 0 ? '$h:$m:$s' : '$m:$s';
}

/// Color for a time ratio (elapsed / expected): green while on time, then
/// shifting through amber and orange to red the more it is exceeded.
Color timeStatusColor(double ratio) {
  if (ratio <= 1) return AppColors.success;
  if (ratio <= 1.25) {
    return Color.lerp(
      AppColors.warning,
      AppColors.primary,
      (ratio - 1) / 0.25,
    )!;
  }
  if (ratio <= 1.5) {
    return Color.lerp(
      AppColors.primary,
      AppColors.danger,
      (ratio - 1.25) / 0.25,
    )!;
  }
  return AppColors.danger;
}
