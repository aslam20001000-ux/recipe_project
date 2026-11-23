import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_project/app.dart';
import 'package:recipe_project/data/models/cook_level.dart';
import 'package:recipe_project/data/models/diet_type.dart';
import 'package:recipe_project/data/repository/recipe_repository.dart';
import 'package:recipe_project/data/repository/recipe_tags.dart';
import 'package:recipe_project/l10n/app_localizations_ar.dart';
import 'package:recipe_project/l10n/app_localizations_en.dart';
import 'package:recipe_project/l10n/l10n_labels.dart';
import 'package:recipe_project/state/challenge_controller.dart';
import 'package:recipe_project/state/recipe_filter.dart';

void main() {
  final repo = RecipeRepository();
  final en = AppLocalizationsEn();
  final ar = AppLocalizationsAr();

  group('Data', () {
    test("today's challenge is found from the data pool", () {
      expect(repo.todaysChallenge?.id, 'koshari');
    });

    test('every recipe is fully translated', () {
      for (final r in repo.all) {
        expect(r.name.ar, isNotEmpty, reason: r.id);
        expect(r.description.ar, isNotEmpty, reason: r.id);
        for (final s in r.steps) {
          expect(s.title.ar, isNotEmpty, reason: r.id);
          expect(s.description.ar, isNotEmpty, reason: r.id);
        }
        for (final i in r.ingredients) {
          expect(i.name.ar, isNotEmpty, reason: r.id);
        }
      }
    });

    test('pool contains Egyptian dishes', () {
      final egyptian = RecipeFilter(
        tags: {RecipeTags.egyptian},
      ).apply(repo.all);
      expect(egyptian.length, greaterThanOrEqualTo(18));
    });

    test('tagines are tagged and include meat with onion', () {
      final tagines = RecipeFilter(tags: {RecipeTags.tagine}).apply(repo.all);
      expect(tagines.length, greaterThanOrEqualTo(10));
      expect(tagines.every((r) => r.diet == DietType.meat), isTrue);
      expect(repo.byId('tagine-meat-onion'), isNotNull);
    });

    test('pool has plenty of meat and chicken dishes', () {
      final meat = RecipeFilter(diet: DietType.meat).apply(repo.all);
      expect(meat.length, greaterThanOrEqualTo(24));
      expect(repo.all.map((r) => r.id).toSet().length, repo.all.length);
    });

    test('cook level scales step durations', () {
      final r = repo.todaysChallenge!;
      expect(
        r.totalDurationFor(CookLevel.intermediate),
        const Duration(minutes: 70),
      );
      expect(
        r.totalDurationFor(CookLevel.beginner),
        const Duration(minutes: 105),
      );
    });

    test('filter combines query, diet and tags', () {
      const f = RecipeFilter(query: 'chicken', diet: DietType.meat);
      expect(f.apply(repo.all).every((r) => r.diet == DietType.meat), isTrue);
      expect(f.apply(repo.all), isNotEmpty);
      expect(
        RecipeFilter(
          tags: {RecipeTags.pasta, RecipeTags.spicy},
        ).apply(repo.all).single.id,
        'spicy-arrabiata-penne',
      );
    });

    test('search works in Arabic too', () {
      final hits = const RecipeFilter(query: 'كشري').apply(repo.all);
      expect(hits.single.id, 'koshari');
    });

    test('greeting follows time of day in both languages', () {
      expect(greetingFor(DateTime(2026, 1, 1, 8), en), 'Good Morning');
      expect(greetingFor(DateTime(2026, 1, 1, 14), en), 'Good Afternoon');
      expect(greetingFor(DateTime(2026, 1, 1, 8), ar), 'صباح الخير');
    });

    test('minutes are pluralised', () {
      expect(formatMinutes(const Duration(minutes: 1), en), '1 Minute');
      expect(formatMinutes(const Duration(minutes: 40), en), '40 Minutes');
      expect(formatMinutes(const Duration(minutes: 5), ar), '5 دقائق');
      expect(formatMinutes(const Duration(minutes: 90), en), '1h 30m');
    });
  });

  test('challenge controller records steps and finishes', () {
    final c = ChallengeController(
      recipe: repo.byId('fried-rice')!,
      level: CookLevel.chef,
    );
    expect(c.currentIndex, 0);
    c.completeStep();
    c.completeStep();
    expect(c.isLastStep, isTrue);
    c.completeStep();
    expect(c.isFinished, isTrue);
    expect(c.buildResult().actualStepTimes.length, 3);
    expect(c.buildResult().beatTheClock, isTrue);
    c.dispose();
  });

  testWidgets('onboarding leads to a personalised explore screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const RecipeApp(initialLocale: Locale('en')));
    expect(find.text('Tell Me More'), findsOneWidget);

    await tester.tap(find.text('Tell Me More'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('I Am Ready'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Chef'));
    await tester.enterText(find.byType(TextField), 'Ahmed');
    await tester.pump();
    await tester.tap(find.text("Let's Go!"));
    await tester.pumpAndSettle();

    expect(find.textContaining('Ahmed', findRichText: true), findsOneWidget);
    expect(find.text("Today's Challenge"), findsOneWidget);
    expect(find.text('Koshari'), findsWidgets);
  });

  testWidgets('Arabic runs right-to-left and can switch back to English', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const RecipeApp(initialLocale: Locale('ar')));
    expect(find.text('قولي أكتر'), findsOneWidget);
    final dir = Directionality.of(tester.element(find.text('قولي أكتر')));
    expect(dir, TextDirection.rtl);

    await tester.tap(find.text('قولي أكتر'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('أنا جاهز'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('شيف'));
    await tester.enterText(find.byType(TextField), 'أحمد');
    await tester.pump();
    await tester.tap(find.text('يلا بينا!'));
    await tester.pumpAndSettle();

    expect(find.text('تحدي النهارده'), findsOneWidget);
    expect(find.text('كشري'), findsWidgets);

    // Switch language from the Explore header.
    await tester.tap(find.byTooltip('اللغة'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text("Today's Challenge"), findsOneWidget);
  });
}
