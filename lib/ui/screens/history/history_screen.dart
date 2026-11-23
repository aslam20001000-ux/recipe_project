import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../l10n/l10n_labels.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/challenge_result.dart';
import '../../../state/history_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/page_header.dart';
import '../../widgets/recipe_image.dart';

/// Past challenges with a small stats summary.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<HistoryController>();
    final results = history.results;
    final padding = context.pagePadding;

    return SafeArea(
      bottom: false,
      child: MaxWidthBox(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(padding, 16, padding, 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageHeader(
                      title: context.l10n.history,
                      subtitle: context.l10n.historySubtitle,
                    ),
                    if (results.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _StatTile(
                            label: context.l10n.challenges,
                            value: '${history.totalChallenges}',
                            icon: Icons.local_fire_department_outlined,
                          ),
                          const SizedBox(width: 10),
                          _StatTile(
                            label: context.l10n.beatTheClock,
                            value: '${history.wins}',
                            icon: Icons.emoji_events_outlined,
                          ),
                          const SizedBox(width: 10),
                          _StatTile(
                            label: context.l10n.winRate,
                            value:
                                '${(history.wins / history.totalChallenges * 100).round()}%',
                            icon: Icons.bar_chart_rounded,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (results.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.history,
                  title: context.l10n.noHistoryTitle,
                  message: context.l10n.noHistoryBody,
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(padding, 0, padding, 24),
                sliver: SliverGrid.builder(
                  itemCount: results.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 560,
                    mainAxisExtent: 108,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (_, i) => _ResultTile(results[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(height: 8),
          Text(value, style: AppText.heading),
          Text(
            label,
            style: AppText.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

class _ResultTile extends StatelessWidget {
  const _ResultTile(this.result);

  final ChallengeResult result;

  @override
  Widget build(BuildContext context) {
    final won = result.beatTheClock;
    final color = won ? AppColors.success : AppColors.danger;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 74,
            child: RecipeImage(
              result.imageUrl,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.tr(result.recipeName),
                  style: AppText.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${result.level.emoji} ${result.level.label(context.l10n)}  ·  '
                  '${formatDate(result.completedAt, Localizations.localeOf(context))}',
                  style: AppText.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '${formatClock(result.actualTotal)} / '
                  '${formatClock(result.expectedTotal)}',
                  style: AppText.caption.copyWith(color: color),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              won ? context.l10n.beatIt : context.l10n.overTime,
              style: TextStyle(fontSize: 11, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
