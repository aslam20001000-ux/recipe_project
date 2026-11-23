import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Ready-made questions the user can tap to ask in one go.
class SuggestionChips extends StatelessWidget {
  const SuggestionChips({
    super.key,
    required this.suggestions,
    required this.onSelected,
  });

  final List<String> suggestions;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) => Wrap(
    alignment: WrapAlignment.center,
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final s in suggestions)
        ActionChip(
          avatar: const Icon(
            Icons.chat_bubble_outline,
            size: 16,
            color: AppColors.primary,
          ),
          label: Text(
            s,
            style: AppText.caption.copyWith(color: AppColors.textPrimary),
          ),
          backgroundColor: AppColors.surface,
          side: const BorderSide(color: AppColors.border),
          onPressed: () => onSelected(s),
        ),
    ],
  );
}
