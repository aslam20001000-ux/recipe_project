import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/l10n_labels.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/repository/recipe_repository.dart';
import '../../../state/recipe_filter.dart';
import '../../navigation.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/recipe_collection.dart';
import 'widgets/filter_sheet.dart';
import 'widgets/greeting_header.dart';
import 'widgets/random_recipe_card.dart';
import 'widgets/recipe_search_bar.dart';
import 'widgets/todays_challenge_card.dart';

/// Main discovery screen.
///
/// Ephemeral state: the [RecipeFilter] and the list/grid view mode.
/// The visible list is inferred from the repository + filter on each build.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  RecipeFilter _filter = const RecipeFilter();
  RecipeViewMode _mode = RecipeViewMode.list;

  Future<void> _openFilters(RecipeRepository repo) async {
    final result = await showFilterSheet(
      context,
      initial: _filter,
      allTags: repo.allTags,
    );
    if (result != null) setState(() => _filter = result);
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.read<RecipeRepository>();
    final challenge = repo.todaysChallenge;
    final recipes = _filter.apply(repo.all);
    final padding = context.pagePadding;

    final challengeCard = challenge == null
        ? const SizedBox.shrink()
        : TodaysChallengeCard(
            recipe: challenge,
            onOpen: () => AppNavigator.openRecipe(context, challenge),
            onStart: () => AppNavigator.startChallenge(context, challenge),
          );
    final randomCard = RandomRecipeCard(
      onTap: () => AppNavigator.openRecipe(context, repo.randomRecipe()),
    );

    return SafeArea(
      bottom: false,
      child: MaxWidthBox(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(padding, 16, padding, 0),
              sliver: SliverList.list(
                children: [
                  const GreetingHeader(),
                  const SizedBox(height: 20),
                  // Side by side on wide windows, stacked on phones.
                  if (context.isExpanded)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(flex: 2, child: challengeCard),
                        const SizedBox(width: 16),
                        Expanded(child: randomCard),
                      ],
                    )
                  else ...[
                    challengeCard,
                    const SizedBox(height: 12),
                    randomCard,
                  ],
                  const SizedBox(height: 28),
                  Text(context.l10n.recipes, style: AppText.heading),
                  const SizedBox(height: 12),
                  RecipeSearchBar(
                    onQueryChanged: (q) =>
                        setState(() => _filter = _filter.copyWith(query: q)),
                    mode: _mode,
                    onModeChanged: (m) => setState(() => _mode = m),
                    onFilterTap: () => _openFilters(repo),
                    activeFilters: _filter.activeCount,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            if (recipes.isEmpty)
              SliverToBoxAdapter(
                child: EmptyState(
                  icon: Icons.search_off,
                  title: context.l10n.noRecipesTitle,
                  message: context.l10n.noRecipesBody,
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(padding, 0, padding, 24),
                sliver: RecipeCollectionSliver(
                  recipes: recipes,
                  mode: _mode,
                  onTap: (r) => AppNavigator.openRecipe(context, r),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
