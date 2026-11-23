import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/recipe.dart';
import '../../../l10n/l10n_labels.dart';
import '../../navigation.dart';
import '../../widgets/blur_icon_button.dart';
import '../../widgets/favorite_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/segmented_tabs.dart';
import 'widgets/overview_tab.dart';
import 'widgets/recipe_header.dart';
import 'widgets/steps_tab.dart';

/// Recipe details: image header with gradient, blurred toolbar, title brief,
/// and an Overview / Steps switcher.
///
/// Phones/tablets: collapsing image header above the content.
/// Wide windows: image panel on the left, scrollable content on the right.
class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  int _tab = 0; // Ephemeral: selected tab.

  Recipe get recipe => widget.recipe;

  Widget get _backButton => BlurIconButton(
    tooltip: context.l10n.back,
    onPressed: () => Navigator.maybePop(context),
    child: const Icon(Icons.arrow_back),
  );

  Widget get _favoriteButton => BlurIconButton(child: FavoriteButton(recipe));

  Widget _content() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SegmentedTabs(
        labels: [context.l10n.overview, context.l10n.steps],
        index: _tab,
        onChanged: (i) => setState(() => _tab = i),
      ),
      const SizedBox(height: 20),
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: KeyedSubtree(
          key: ValueKey(_tab),
          child: _tab == 0
              ? OverviewTab(recipe: recipe)
              : StepsTab(recipe: recipe),
        ),
      ),
    ],
  );

  Widget _startBar() => SafeArea(
    top: false,
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        context.pagePadding,
        8,
        context.pagePadding,
        16,
      ),
      child: Row(
        children: [
          IconButton.outlined(
            tooltip: context.l10n.askChef,
            style: IconButton.styleFrom(
              minimumSize: const Size(48, 48),
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => AppNavigator.askAboutRecipe(context, recipe),
            icon: const Icon(Icons.auto_awesome),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PrimaryButton(
              label: context.l10n.startChallenge,
              icon: Icons.timer_outlined,
              onPressed: () => AppNavigator.startChallenge(context, recipe),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) =>
      context.isExpanded ? _buildWide() : _buildNarrow();

  Widget _buildNarrow() {
    final padding = context.pagePadding;
    return Scaffold(
      bottomNavigationBar: MaxWidthBox(maxWidth: 800, child: _startBar()),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: MediaQuery.sizeOf(context).height * 0.45,
            backgroundColor: AppColors.background,
            automaticallyImplyLeading: false,
            leadingWidth: 64,
            leading: Padding(
              padding: const EdgeInsetsDirectional.only(start: 12),
              child: Center(child: _backButton),
            ),
            actions: [_favoriteButton, const SizedBox(width: 12)],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: const [StretchMode.zoomBackground],
              background: RecipeHeader(recipe: recipe),
            ),
          ),
          SliverToBoxAdapter(
            child: MaxWidthBox(
              maxWidth: 800,
              child: Padding(
                padding: EdgeInsets.fromLTRB(padding, 8, padding, 24),
                child: _content(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWide() => Scaffold(
    body: Row(
      children: [
        Expanded(
          flex: 5,
          child: Stack(
            fit: StackFit.expand,
            children: [
              RecipeHeader(recipe: recipe),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_backButton, _favoriteButton],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                    child: MaxWidthBox(maxWidth: 760, child: _content()),
                  ),
                ),
                MaxWidthBox(maxWidth: 760, child: _startBar()),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
