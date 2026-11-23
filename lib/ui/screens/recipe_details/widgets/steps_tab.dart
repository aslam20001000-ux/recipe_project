import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/recipe.dart';
import '../../../../state/user_controller.dart';
import '../../../widgets/step_card.dart';

/// All steps with the expected time for the current cook level.
class StepsTab extends StatelessWidget {
  const StepsTab({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final level = context.select((UserController u) => u.level);
    return Column(
      children: [
        for (final (i, step) in recipe.steps.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: StepCard(
              step: step,
              number: i + 1,
              expected: step.durationFor(level),
            ),
          ),
      ],
    );
  }
}
