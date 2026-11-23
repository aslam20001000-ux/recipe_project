import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/l10n_labels.dart';
import '../../data/models/recipe.dart';
import '../../state/user_controller.dart';

/// "⏱ 40 Minutes · ⤳ 4 Steps", time scaled by the user's cook level.
class RecipeMeta extends StatelessWidget {
  const RecipeMeta(this.recipe, {super.key, this.color});

  final Recipe recipe;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final level = context.select((UserController u) => u.level);
    final c = color ?? AppColors.textSecondary;
    final l10n = context.l10n;

    WidgetSpan icon(IconData data) => WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 4),
        child: Icon(data, size: 13, color: c),
      ),
    );

    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 12, color: c),
        children: [
          icon(Icons.schedule),
          TextSpan(text: formatMinutes(recipe.totalDurationFor(level), l10n)),
          const TextSpan(text: '  ·  '),
          icon(Icons.route_outlined),
          TextSpan(text: l10n.stepsCount(recipe.stepCount)),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
