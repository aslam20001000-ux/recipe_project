import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/cook_level.dart';
import '../../../l10n/l10n_labels.dart';
import '../../../state/user_controller.dart';
import '../../widgets/highlighted_title.dart';
import '../../widgets/language_button.dart';
import '../../widgets/page_dots.dart';
import '../../widgets/primary_button.dart';
import 'widgets/chef_illustration.dart';
import 'widgets/feature_card.dart';
import 'widgets/level_option_card.dart';

/// Three onboarding pages: intro, features, and the level + name form.
///
/// The page index, selected level and typed name are ephemeral state owned
/// here; only on "Let's Go!" are they committed to [UserController].
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pageCount = 3;

  final _pageController = PageController();
  final _nameController = TextEditingController();
  int _page = 0;
  CookLevel? _level;

  bool get _isLastPage => _page == _pageCount - 1;
  bool get _canFinish =>
      _level != null && _nameController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _goTo(int page) => _pageController.animateToPage(
    page,
    duration: const Duration(milliseconds: 350),
    curve: Curves.easeOutCubic,
  );

  void _onPrimary() {
    if (!_isLastPage) return _goTo(_page + 1);
    if (!_canFinish) return;
    context.read<UserController>().completeOnboarding(
      name: _nameController.text,
      level: _level!,
    );
  }

  String _buttonLabel(AppLocalizations l) => switch (_page) {
    0 => l.tellMeMore,
    1 => l.iAmReady,
    _ => l.letsGo,
  };

  IconData get _buttonIcon => switch (_page) {
    0 => Icons.arrow_forward,
    1 => Icons.timer_outlined,
    _ => Icons.rocket_launch_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final wide = !context.isCompact;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  const LanguageButton(),
                  const Spacer(),
                  IconButton(
                    tooltip: context.l10n.skip,
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: _isLastPage ? null : () => _goTo(_pageCount - 1),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (p) => setState(() => _page = p),
                children: [
                  _IntroPage(wide: wide),
                  _FeaturesPage(wide: wide),
                  _LevelPage(
                    wide: wide,
                    selected: _level,
                    onSelect: (l) => setState(() => _level = l),
                    nameController: _nameController,
                    onSubmit: _onPrimary,
                  ),
                ],
              ),
            ),
            MaxWidthBox(
              maxWidth: 520,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  context.pagePadding,
                  8,
                  context.pagePadding,
                  20,
                ),
                child: Column(
                  children: [
                    PrimaryButton(
                      label: _buttonLabel(context.l10n),
                      icon: _buttonIcon,
                      onPressed: _isLastPage && !_canFinish ? null : _onPrimary,
                    ),
                    const SizedBox(height: 16),
                    PageDots(count: _pageCount, index: _page),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Scrollable, centered, width-capped page body.
class _PageBody extends StatelessWidget {
  const _PageBody({required this.children, this.maxWidth = 560});

  final List<Widget> children;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    ),
  );
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) => _PageBody(
    children: [
      ChefIllustration(size: wide ? 340 : 240),
      const SizedBox(height: 32),
      HighlightedTitle(
        text: _titlePrefix(context.l10n.introTitlePrefix, wide),
        highlight: context.l10n.introTitleHighlight,
      ),
      const SizedBox(height: 12),
      Text(
        context.l10n.introBody,
        style: AppText.body,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

/// On narrow screens the highlighted part of a title goes on its own line.
String _titlePrefix(String prefix, bool wide) =>
    wide ? prefix : '${prefix.trimRight()}\n';

class _FeaturesPage extends StatelessWidget {
  const _FeaturesPage({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final features = [
      (Icons.timer_outlined, l.featureTimeTitle, l.featureTimeBody),
      (Icons.military_tech_outlined, l.featureClockTitle, l.featureClockBody),
      (Icons.bar_chart_rounded, l.featureProgressTitle, l.featureProgressBody),
    ];
    return _build(l, features);
  }

  Widget _build(
    AppLocalizations l,
    List<(IconData, String, String)> features,
  ) => _PageBody(
    maxWidth: wide ? 720 : 560,
    children: [
      HighlightedTitle(
        text: l.featuresTitlePrefix,
        highlight: l.featuresTitleHighlight,
      ),
      const SizedBox(height: 32),
      if (wide)
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (i, f) in features.indexed) ...[
                if (i > 0) const SizedBox(width: 12),
                Expanded(
                  child: FeatureCard(
                    icon: f.$1,
                    title: f.$2,
                    subtitle: f.$3,
                    vertical: true,
                  ),
                ),
              ],
            ],
          ),
        )
      else
        for (final f in features)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FeatureCard(icon: f.$1, title: f.$2, subtitle: f.$3),
          ),
    ],
  );
}

class _LevelPage extends StatelessWidget {
  const _LevelPage({
    required this.wide,
    required this.selected,
    required this.onSelect,
    required this.nameController,
    required this.onSubmit,
  });

  final bool wide;
  final CookLevel? selected;
  final ValueChanged<CookLevel> onSelect;
  final TextEditingController nameController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    LevelOptionCard card(CookLevel l) => LevelOptionCard(
      level: l,
      selected: l == selected,
      vertical: wide,
      onTap: () => onSelect(l),
    );

    return _PageBody(
      maxWidth: wide ? 720 : 560,
      children: [
        HighlightedTitle(
          text: _titlePrefix(context.l10n.levelTitlePrefix, wide),
          highlight: context.l10n.levelTitleHighlight,
        ),
        const SizedBox(height: 10),
        Text(
          context.l10n.levelSubtitle,
          style: AppText.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        if (wide)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (i, l) in CookLevel.values.indexed) ...[
                  if (i > 0) const SizedBox(width: 12),
                  Expanded(child: card(l)),
                ],
              ],
            ),
          )
        else
          for (final l in CookLevel.values)
            Padding(padding: const EdgeInsets.only(bottom: 10), child: card(l)),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => onSubmit(),
            decoration: InputDecoration(hintText: context.l10n.enterName),
          ),
        ),
      ],
    );
  }
}
