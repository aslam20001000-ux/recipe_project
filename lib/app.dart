import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/repository/recipe_repository.dart';
import 'l10n/app_localizations.dart';
import 'services/chef_assistant.dart';
import 'services/local_chef_assistant.dart';
import 'state/favorites_controller.dart';
import 'state/history_controller.dart';
import 'state/locale_controller.dart';
import 'state/user_controller.dart';
import 'ui/screens/onboarding/onboarding_screen.dart';
import 'ui/screens/shell/main_shell.dart';

/// Root widget. Provides the shared, app-wide state:
///
/// * [RecipeRepository] – read-only data pool.
/// * [ChefAssistant]    – cooking assistant: Claude when an API key is set,
///                        otherwise an offline one that uses the app's recipes.
/// * [LocaleController] – chosen app language (English / Arabic).
/// * [UserController]   – name + cook level from onboarding.
/// * [FavoritesController] – favorite recipe ids.
/// * [HistoryController]   – finished challenge results.
///
/// Screen-specific state (filters, selected tab, running challenge timer)
/// is ephemeral and lives in the screens themselves.
class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key, this.initialLocale, this.assistant});

  /// Forces a starting language (used by tests); otherwise follows the device.
  final Locale? initialLocale;

  /// Replaces the Claude-backed assistant (used by tests).
  final ChefAssistant? assistant;

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider(create: (_) => RecipeRepository()),
      Provider<ChefAssistant>(
        create: (context) => assistant ?? _defaultAssistant(context),
      ),
      ChangeNotifierProvider(
        create: (_) => LocaleController(initial: initialLocale),
      ),
      ChangeNotifierProvider(create: (_) => UserController()),
      ChangeNotifierProvider(create: (_) => FavoritesController()),
      ChangeNotifierProvider(create: (_) => HistoryController()),
    ],
    child: Builder(
      builder: (context) => MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        locale: context.select((LocaleController l) => l.locale),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const _Root(),
      ),
    ),
  );
}

/// Claude when the app was built with `ANTHROPIC_API_KEY`, otherwise the
/// offline assistant, so the chat works with no key and no internet.
ChefAssistant _defaultAssistant(BuildContext context) {
  final recipes = context.read<RecipeRepository>().all;
  const key = String.fromEnvironment('ANTHROPIC_API_KEY');
  return key.isEmpty
      ? LocalChefAssistant(
          recipes: recipes,
          typingDelay: const Duration(milliseconds: 40),
        )
      : ClaudeChefAssistant(recipes: recipes);
}

/// Shows onboarding until the user completes it, then the main shell.
class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    final onboarded = context.select((UserController u) => u.hasOnboarded);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: onboarded ? const MainShell() : const OnboardingScreen(),
    );
  }
}
