import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_project/ui/widgets/segmented_tabs.dart';
import 'package:recipe_project/app.dart';
import 'package:recipe_project/l10n/app_localizations.dart';
import 'package:recipe_project/l10n/app_localizations_ar.dart';
import 'package:recipe_project/l10n/app_localizations_en.dart';

import 'fake_assistant.dart';

void main() {
  for (final lang in const ['en', 'ar']) {
    final isAr = lang == 'ar';
    final AppLocalizations l = isAr
        ? AppLocalizationsAr()
        : AppLocalizationsEn();
    for (final size in const [
      Size(360, 740),
      Size(820, 1180),
      Size(1440, 900),
      Size(1024, 640),
    ]) {
      testWidgets('[$lang] all screens render without overflow at $size', (
        t,
      ) async {
        t.view.physicalSize = size;
        t.view.devicePixelRatio = 1;
        addTearDown(t.view.reset);

        await t.pumpWidget(
          RecipeApp(
            initialLocale: Locale(lang),
            assistant: FakeAssistant(answer: 'word ' * 120),
          ),
        );
        await t.tap(find.text(l.tellMeMore));
        await t.pumpAndSettle();
        await t.tap(find.text(l.iAmReady));
        await t.pumpAndSettle();
        await t.tap(find.text(l.levelIntermediate));
        await t.enterText(find.byType(TextField), 'Ahmed');
        await t.pump();
        await t.tap(find.text(l.letsGo));
        await t.pumpAndSettle();

        // Grid mode.
        await t.scrollUntilVisible(
          find.byTooltip(l.filter),
          150,
          scrollable: find
              .descendant(
                of: find.byType(CustomScrollView),
                matching: find.byType(Scrollable),
              )
              .first,
        );
        await t.ensureVisible(find.byTooltip(l.filter));
        await t.pumpAndSettle();
        await t.tap(find.byTooltip(l.gridView));
        await t.pumpAndSettle();
        await t.ensureVisible(find.byTooltip(l.listView));
        await t.pumpAndSettle();
        await t.tap(find.byTooltip(l.listView));
        await t.pumpAndSettle();

        // Filter sheet.
        await t.ensureVisible(find.byTooltip(l.filter));
        await t.pumpAndSettle();
        await t.tap(find.byTooltip(l.filter));
        await t.pumpAndSettle();
        await t.tap(find.text(l.dietPlant));
        await t.ensureVisible(find.text(l.applyFilters));
        await t.pumpAndSettle();
        await t.tap(find.text(l.applyFilters));
        await t.pumpAndSettle();

        await t.ensureVisible(find.byTooltip(l.addToFavorites).first);
        await t.pumpAndSettle();
        // Favorite something and view favorites/history tabs.
        await t.tap(find.byTooltip(l.addToFavorites).first);
        await t.pump();
        await t.tap(find.text(l.favorites).last);
        await t.pumpAndSettle();
        await t.tap(find.text(l.history).last);
        await t.pumpAndSettle();
        // Chef AI tab with a long streamed answer.
        await t.tap(find.text(l.assistant).last);
        await t.pumpAndSettle();
        await t.tap(find.text(l.suggestGeneral1));
        await t.pumpAndSettle();
        expect(find.textContaining('word word'), findsOneWidget);
        await t.tap(find.text(l.explore).last);
        await t.pumpAndSettle();

        await t.drag(
          find.byType(CustomScrollView).first,
          const Offset(0, 3000),
        );
        await t.pumpAndSettle();
        // Details via today's challenge card.
        await t.tap(find.text(isAr ? 'كشري' : 'Koshari').first);
        await t.pumpAndSettle();
        // Ask about this dish, then come back.
        await t.tap(find.byTooltip(l.askChef));
        await t.pumpAndSettle();
        await t.tap(find.text(l.suggestDish1(isAr ? 'كشري' : 'Koshari')));
        await t.pumpAndSettle();
        await t.tap(find.byTooltip(l.back));
        await t.pumpAndSettle();
        await t.tap(
          find.descendant(
            of: find.byType(SegmentedTabs),
            matching: find.text(l.steps),
          ),
        );
        await t.pumpAndSettle();
        await t.tap(find.text(l.startChallenge).last);
        await t.pumpAndSettle();

        expect(find.text(l.nextStep), findsOneWidget);
        while (find.text(l.nextStep).evaluate().isNotEmpty) {
          await t.pump(const Duration(seconds: 2));
          await t.tap(find.text(l.nextStep));
          await t.pumpAndSettle();
        }
        await t.tap(find.text(l.finishChallenge));
        await t.pumpAndSettle();
        expect(find.text(l.youBeatTheClock), findsOneWidget);
        await t.tap(find.text(l.done));
        await t.pumpAndSettle();

        // Back to explore, check history.
        await t.tap(find.byTooltip(l.back));
        await t.pumpAndSettle();
        await t.tap(find.text(l.history).last);
        await t.pumpAndSettle();
        expect(find.text(l.beatIt), findsOneWidget);
      });
    }
  }
}
