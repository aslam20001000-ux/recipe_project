import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../l10n/l10n_labels.dart';
import '../assistant/assistant_screen.dart';
import '../explore/explore_screen.dart';
import '../favorites/favorites_screen.dart';
import '../history/history_screen.dart';

/// Main navigation. Bottom bar on phones, side rail on larger windows.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static List<(IconData, IconData, String)> _destinations(AppLocalizations l) =>
      [
        (Icons.restaurant_menu_outlined, Icons.restaurant_menu, l.explore),
        (Icons.auto_awesome_outlined, Icons.auto_awesome, l.assistant),
        (Icons.favorite_border, Icons.favorite, l.favorites),
        (Icons.bar_chart_outlined, Icons.bar_chart, l.history),
      ];

  static const _pages = [
    ExploreScreen(),
    AssistantScreen(),
    FavoritesScreen(),
    HistoryScreen(),
  ];

  void _select(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final body = IndexedStack(index: _index, children: _pages);

    if (context.isCompact) {
      return Scaffold(
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: _select,
          height: 68,
          destinations: [
            for (final d in _destinations(context.l10n))
              NavigationDestination(
                icon: Icon(d.$1),
                selectedIcon: Icon(d.$2),
                label: d.$3,
              ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: _select,
            extended: context.isExpanded,
            minExtendedWidth: 200,
            labelType: context.isExpanded
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Icon(
                Icons.soup_kitchen,
                color: AppColors.primary,
                size: context.isExpanded ? 36 : 28,
              ),
            ),
            destinations: [
              for (final d in _destinations(context.l10n))
                NavigationRailDestination(
                  icon: Icon(d.$1),
                  selectedIcon: Icon(d.$2),
                  label: Text(d.$3),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: body),
        ],
      ),
    );
  }
}
