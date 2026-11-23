import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/diet_type.dart';
import '../../l10n/l10n_labels.dart';

/// Icon badge showing whether a recipe is meat or plant based.
class DietBadge extends StatelessWidget {
  const DietBadge(this.diet, {super.key, this.showLabel = false});

  final DietType diet;
  final bool showLabel;

  Color get _color => diet == DietType.plant ? AppColors.plant : AppColors.meat;

  IconData get _icon =>
      diet == DietType.plant ? Icons.eco_outlined : Icons.set_meal_outlined;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: diet.label(context.l10n),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: showLabel ? 8 : 4, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 14, color: _color),
          if (showLabel) ...[
            const SizedBox(width: 4),
            Text(
              diet.label(context.l10n),
              style: TextStyle(fontSize: 11, color: _color),
            ),
          ],
        ],
      ),
    ),
  );
}
