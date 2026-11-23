import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/cook_level.dart';
import '../../../../l10n/l10n_labels.dart';

/// Selectable card for a [CookLevel].
class LevelOptionCard extends StatelessWidget {
  const LevelOptionCard({
    super.key,
    required this.level,
    required this.selected,
    required this.onTap,
    this.vertical = false,
  });

  final CookLevel level;
  final bool selected;
  final VoidCallback onTap;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final texts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          level.label(context.l10n),
          style: AppText.title.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 2),
        Text(level.description(context.l10n), style: AppText.caption),
      ],
    );
    final emoji = Text(level.emoji, style: const TextStyle(fontSize: 22));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: vertical
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [emoji, const SizedBox(height: 12), texts],
                  )
                : Row(
                    children: [
                      emoji,
                      const SizedBox(width: 14),
                      Expanded(child: texts),
                      if (selected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 20,
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
