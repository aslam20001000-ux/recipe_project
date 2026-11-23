import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/l10n_labels.dart';
import '../../../../data/models/cook_level.dart';
import '../../../../state/user_controller.dart';

/// Compact dropdown to change the shared cook level. Changing it rescales the
/// expected time of every step across the app.
class LevelDropdown extends StatelessWidget {
  const LevelDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final level = context.select((UserController u) => u.level);
    return PopupMenuButton<CookLevel>(
      tooltip: context.l10n.changeCookLevel,
      initialValue: level,
      position: PopupMenuPosition.under,
      onSelected: context.read<UserController>().setLevel,
      itemBuilder: (_) => [
        for (final l in CookLevel.values)
          PopupMenuItem(
            value: l,
            child: Row(
              children: [
                Text(l.emoji),
                const SizedBox(width: 10),
                Text(l.label(context.l10n)),
                const Spacer(),
                Text(
                  '×${l.timeFactor}',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(level.emoji, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 6),
            Text(
              level.label(context.l10n),
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
