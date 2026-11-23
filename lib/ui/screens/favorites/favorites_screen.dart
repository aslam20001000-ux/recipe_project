import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/responsive.dart';
import '../../../l10n/l10n_labels.dart';
import '../../../data/repository/recipe_repository.dart';
import '../../../state/favorites_controller.dart';
import '../../navigation.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/page_header.dart';
import '../../widgets/recipe_collection.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final all = context.read<RecipeRepository>().all;
    final favorites = context.watch<FavoritesController>().favoritesFrom(all);
    final padding = context.pagePadding;

    return SafeArea(
      bottom: false,
      child: MaxWidthBox(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(padding, 16, padding, 20),
              sliver: SliverToBoxAdapter(
                child: PageHeader(
                  title: context.l10n.favorites,
                  subtitle: context.l10n.savedRecipes(favorites.length),
                ),
              ),
            ),
            if (favorites.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.favorite_border,
                  title: context.l10n.noFavoritesTitle,
                  message: context.l10n.noFavoritesBody,
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(padding, 0, padding, 24),
                sliver: RecipeCollectionSliver(
                  recipes: favorites,
                  onTap: (r) => AppNavigator.openRecipe(context, r),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
