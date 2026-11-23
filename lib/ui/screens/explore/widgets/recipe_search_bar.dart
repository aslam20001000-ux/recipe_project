import 'package:flutter/material.dart';

import '../../../../l10n/l10n_labels.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../widgets/recipe_collection.dart';

/// Search field + grid/list switch + filter button.
class RecipeSearchBar extends StatelessWidget {
  const RecipeSearchBar({
    super.key,
    required this.onQueryChanged,
    required this.mode,
    required this.onModeChanged,
    required this.onFilterTap,
    required this.activeFilters,
  });

  final ValueChanged<String> onQueryChanged;
  final RecipeViewMode mode;
  final ValueChanged<RecipeViewMode> onModeChanged;
  final VoidCallback onFilterTap;
  final int activeFilters;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: SizedBox(
          height: 42,
          child: TextField(
            onChanged: onQueryChanged,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: context.l10n.searchHint,
              prefixIcon: const Icon(
                Icons.search,
                size: 20,
                color: AppColors.textMuted,
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Container(
        height: 42,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            _ModeButton(
              icon: Icons.grid_view_rounded,
              tooltip: context.l10n.gridView,
              selected: mode == RecipeViewMode.grid,
              onTap: () => onModeChanged(RecipeViewMode.grid),
            ),
            _ModeButton(
              icon: Icons.view_list_rounded,
              tooltip: context.l10n.listView,
              selected: mode == RecipeViewMode.list,
              onTap: () => onModeChanged(RecipeViewMode.list),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      Badge.count(
        count: activeFilters,
        isLabelVisible: activeFilters > 0,
        backgroundColor: AppColors.primary,
        child: SizedBox.square(
          dimension: 42,
          child: IconButton.outlined(
            tooltip: context.l10n.filter,
            onPressed: onFilterTap,
            style: IconButton.styleFrom(
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.filter_alt_outlined, size: 20),
          ),
        ),
      ),
    ],
  );
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.icon,
    required this.tooltip,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 34,
        decoration: BoxDecoration(
          color: selected ? AppColors.surfaceHigh : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          icon,
          size: 18,
          color: selected ? AppColors.textPrimary : AppColors.textMuted,
        ),
      ),
    ),
  );
}
