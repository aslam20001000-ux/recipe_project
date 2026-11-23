import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/l10n_labels.dart';
import '../../../../data/models/localized_text.dart';
import '../../../../data/models/diet_type.dart';
import '../../../../state/recipe_filter.dart';
import '../../../widgets/primary_button.dart';

/// Bottom sheet to edit a [RecipeFilter]. Returns the new filter on apply.
Future<RecipeFilter?> showFilterSheet(
  BuildContext context, {
  required RecipeFilter initial,
  required List<LocalizedText> allTags,
}) => showModalBottomSheet<RecipeFilter>(
  context: context,
  isScrollControlled: true,
  constraints: const BoxConstraints(maxWidth: 640),
  builder: (_) => _FilterSheet(initial: initial, allTags: allTags),
);

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.initial, required this.allTags});

  final RecipeFilter initial;
  final List<LocalizedText> allTags;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late DietType? _diet = widget.initial.diet;
  late final Set<LocalizedText> _tags = {...widget.initial.tags};

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(context.l10n.filterRecipes, style: AppText.heading),
              ),
              TextButton(
                onPressed: () => setState(() {
                  _diet = null;
                  _tags.clear();
                }),
                child: Text(context.l10n.reset),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(context.l10n.diet, style: AppText.title),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              _choice(context.l10n.anyDiet, _diet == null, () => _diet = null),
              for (final d in DietType.values)
                _choice(d.label(context.l10n), _diet == d, () => _diet = d),
            ],
          ),
          const SizedBox(height: 20),
          Text(context.l10n.tags, style: AppText.title),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final t in widget.allTags)
                FilterChip(
                  label: Text(context.tr(t)),
                  selected: _tags.contains(t),
                  selectedColor: AppColors.primary.withValues(alpha: 0.25),
                  checkmarkColor: AppColors.primary,
                  onSelected: (v) =>
                      setState(() => v ? _tags.add(t) : _tags.remove(t)),
                ),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: context.l10n.applyFilters,
            onPressed: () => Navigator.pop(
              context,
              widget.initial.copyWith(diet: () => _diet, tags: {..._tags}),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _choice(String label, bool selected, VoidCallback select) =>
      ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: AppColors.primary.withValues(alpha: 0.25),
        onSelected: (_) => setState(select),
      );
}
