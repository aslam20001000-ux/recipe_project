import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/recipe.dart';
import '../../../l10n/l10n_labels.dart';
import '../../../state/challenge_controller.dart';
import '../../../state/history_controller.dart';
import '../../../state/user_controller.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/step_card.dart';
import 'widgets/challenge_summary_dialog.dart';
import 'widgets/challenge_timeline.dart';
import 'widgets/step_indicator.dart';
import 'widgets/time_counter.dart';

/// Entry point: owns the ephemeral [ChallengeController] for this run.
/// The cook level is captured once when the challenge starts.
class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ChallengeController(
      recipe: recipe,
      level: context.read<UserController>().level,
    ),
    child: const _ChallengeView(),
  );
}

class _ChallengeView extends StatelessWidget {
  const _ChallengeView();

  Future<void> _completeStep(BuildContext context) async {
    final controller = context.read<ChallengeController>();
    controller.completeStep();
    if (!controller.isFinished) return;

    final result = controller.buildResult();
    context.read<HistoryController>().add(result);
    await showChallengeSummary(context, result);
    if (context.mounted) Navigator.pop(context);
  }

  Future<void> _confirmExit(BuildContext context) async {
    final controller = context.read<ChallengeController>();
    final wasPaused = controller.isPaused;
    if (!wasPaused) controller.togglePause();

    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.quitTitle),
        content: Text(context.l10n.quitBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.l10n.keepCooking),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(context.l10n.quit),
          ),
        ],
      ),
    );
    if (!context.mounted) return;
    if (leave ?? false) {
      Navigator.pop(context);
    } else if (!wasPaused) {
      controller.togglePause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<ChallengeController>();
    final wide = context.isExpanded;
    final padding = context.pagePadding;

    final stepsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StepIndicator(current: c.currentIndex, total: c.stepCount),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            ),
          ),
          child: StepCard(
            key: ValueKey(c.currentIndex),
            step: c.currentStep,
            number: c.currentIndex + 1,
            expected: c.stepExpected,
            highlighted: true,
            large: true,
            label: context.l10n.currentStep,
          ),
        ),
        if (c.nextStep != null) ...[
          const SizedBox(height: 14),
          Opacity(
            opacity: 0.4,
            child: StepCard(
              step: c.nextStep!,
              number: c.currentIndex + 2,
              expected: c.expectedTimes[c.currentIndex + 1],
              label: context.l10n.upNext,
            ),
          ),
        ],
      ],
    );

    final counter = Center(
      child: TimeCounter(
        elapsed: c.stepElapsed,
        expected: c.stepExpected,
        size: wide ? 240 : 190,
      ),
    );

    final timeline = ChallengeTimeline(
      expected: c.expectedTimes,
      elapsedForStep: c.elapsedForStep,
      currentIndex: c.currentIndex,
      totalElapsed: c.totalElapsed,
      totalExpected: c.totalExpected,
    );

    final actionButton = PrimaryButton(
      label: c.isLastStep
          ? context.l10n.finishChallenge
          : context.l10n.nextStep,
      icon: c.isLastStep ? Icons.flag_outlined : Icons.arrow_forward,
      onPressed: c.isFinished ? null : () => _completeStep(context),
    );

    return PopScope(
      canPop: c.isFinished,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            tooltip: context.l10n.quit,
            icon: const Icon(Icons.close),
            onPressed: () => _confirmExit(context),
          ),
          centerTitle: true,
          title: Column(
            children: [
              Text(context.tr(c.recipe.name), style: AppText.title),
              Text(
                '${c.level.emoji} ${context.l10n.levelChallenge(c.level.label(context.l10n))}',
                style: AppText.caption,
              ),
            ],
          ),
          actions: [
            if (kDebugMode) _SpeedButton(controller: c),
            IconButton(
              tooltip: c.isPaused ? context.l10n.resume : context.l10n.pause,
              icon: Icon(c.isPaused ? Icons.play_arrow : Icons.pause),
              onPressed: c.togglePause,
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: SafeArea(
          child: MaxWidthBox(
            child: wide
                ? Padding(
                    padding: EdgeInsets.all(padding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(child: stepsColumn),
                        ),
                        SizedBox(width: padding),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              counter,
                              const SizedBox(height: 24),
                              timeline,
                              const Spacer(),
                              actionButton,
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(padding, 8, padding, 16),
                          child: MaxWidthBox(
                            maxWidth: 700,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                counter,
                                const SizedBox(height: 20),
                                stepsColumn,
                              ],
                            ),
                          ),
                        ),
                      ),
                      MaxWidthBox(
                        maxWidth: 700,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(padding, 0, padding, 16),
                          child: Column(
                            children: [
                              timeline,
                              const SizedBox(height: 12),
                              actionButton,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Debug-only control to speed up time, handy for demoing the color changes.
class _SpeedButton extends StatelessWidget {
  const _SpeedButton({required this.controller});

  final ChallengeController controller;

  static const _speeds = [1.0, 10.0, 60.0];

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () {
      final i = _speeds.indexOf(controller.speed);
      controller.setSpeed(_speeds[(i + 1) % _speeds.length]);
    },
    child: Text('×${controller.speed.toInt()}'),
  );
}
