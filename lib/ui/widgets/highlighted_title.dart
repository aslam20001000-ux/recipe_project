import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// Serif title where one part is highlighted in the primary color,
/// e.g. "Master Your **Cooking Time**".
class HighlightedTitle extends StatelessWidget {
  const HighlightedTitle({
    super.key,
    required this.text,
    required this.highlight,
    this.suffix = '',
    this.style = AppText.display,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final String highlight;
  final String suffix;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      style: style,
      children: [
        TextSpan(text: text),
        TextSpan(
          text: highlight,
          style: const TextStyle(color: AppColors.primary),
        ),
        if (suffix.isNotEmpty) TextSpan(text: suffix),
      ],
    ),
    textAlign: textAlign,
  );
}
