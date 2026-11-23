import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/localized_text.dart';

/// Small rounded label for a recipe tag.
class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key, this.translucent = false});

  final String label;

  /// Use over images so the chip stays readable.
  final bool translucent;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: translucent
          ? Colors.white.withValues(alpha: 0.14)
          : AppColors.surfaceHigh,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
    ),
  );
}

/// A wrapping row of [TagChip]s.
class TagList extends StatelessWidget {
  const TagList(this.tags, {super.key, this.translucent = false});

  final List<LocalizedText> tags;
  final bool translucent;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
      for (final t in tags) TagChip(context.tr(t), translucent: translucent),
    ],
  );
}
