import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipe Challenge'**
  String get appTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @introTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Master Your '**
  String get introTitlePrefix;

  /// No description provided for @introTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'Cooking Time'**
  String get introTitleHighlight;

  /// No description provided for @introBody.
  ///
  /// In en, this message translates to:
  /// **'Turn cooking into an exciting challenge. Race against time, improve your skills, and become a kitchen champion!'**
  String get introBody;

  /// No description provided for @tellMeMore.
  ///
  /// In en, this message translates to:
  /// **'Tell Me More'**
  String get tellMeMore;

  /// No description provided for @featuresTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Cook, Compete, '**
  String get featuresTitlePrefix;

  /// No description provided for @featuresTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'Conquer'**
  String get featuresTitleHighlight;

  /// No description provided for @featureTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Each Step'**
  String get featureTimeTitle;

  /// No description provided for @featureTimeBody.
  ///
  /// In en, this message translates to:
  /// **'Follow recipe steps with built-in timers'**
  String get featureTimeBody;

  /// No description provided for @featureClockTitle.
  ///
  /// In en, this message translates to:
  /// **'Beat The Clock'**
  String get featureClockTitle;

  /// No description provided for @featureClockBody.
  ///
  /// In en, this message translates to:
  /// **'Match or beat expected cooking times'**
  String get featureClockBody;

  /// No description provided for @featureProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Track Progress'**
  String get featureProgressTitle;

  /// No description provided for @featureProgressBody.
  ///
  /// In en, this message translates to:
  /// **'See your improvement over time'**
  String get featureProgressBody;

  /// No description provided for @iAmReady.
  ///
  /// In en, this message translates to:
  /// **'I Am Ready'**
  String get iAmReady;

  /// No description provided for @levelTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'What\'s Your '**
  String get levelTitlePrefix;

  /// No description provided for @levelTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'Cooking Level?'**
  String get levelTitleHighlight;

  /// No description provided for @levelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us customize your experience and set appropriate challenges'**
  String get levelSubtitle;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @letsGo.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go!'**
  String get letsGo;

  /// No description provided for @levelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get levelBeginner;

  /// No description provided for @levelBeginnerDesc.
  ///
  /// In en, this message translates to:
  /// **'Just starting'**
  String get levelBeginnerDesc;

  /// No description provided for @levelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get levelIntermediate;

  /// No description provided for @levelIntermediateDesc.
  ///
  /// In en, this message translates to:
  /// **'Cooks often, knows a few recipes'**
  String get levelIntermediateDesc;

  /// No description provided for @levelChef.
  ///
  /// In en, this message translates to:
  /// **'Chef'**
  String get levelChef;

  /// No description provided for @levelChefDesc.
  ///
  /// In en, this message translates to:
  /// **'Let me cook!'**
  String get levelChefDesc;

  /// No description provided for @dietMeat.
  ///
  /// In en, this message translates to:
  /// **'Meat based'**
  String get dietMeat;

  /// No description provided for @dietPlant.
  ///
  /// In en, this message translates to:
  /// **'Plant based'**
  String get dietPlant;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get greetingEvening;

  /// No description provided for @greetingNight.
  ///
  /// In en, this message translates to:
  /// **'Good Night'**
  String get greetingNight;

  /// No description provided for @nameSeparator.
  ///
  /// In en, this message translates to:
  /// **', '**
  String get nameSeparator;

  /// No description provided for @readyToCook.
  ///
  /// In en, this message translates to:
  /// **'Ready to cook something amazing?'**
  String get readyToCook;

  /// No description provided for @changeCookLevel.
  ///
  /// In en, this message translates to:
  /// **'Change cook level'**
  String get changeCookLevel;

  /// No description provided for @todaysChallenge.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Challenge'**
  String get todaysChallenge;

  /// No description provided for @startChallenge.
  ///
  /// In en, this message translates to:
  /// **'Start Challenge'**
  String get startChallenge;

  /// No description provided for @randomRecipe.
  ///
  /// In en, this message translates to:
  /// **'Random Recipe'**
  String get randomRecipe;

  /// No description provided for @randomRecipeBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t know what to cook?'**
  String get randomRecipeBody;

  /// No description provided for @recipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get recipes;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a recipe...'**
  String get searchHint;

  /// No description provided for @gridView.
  ///
  /// In en, this message translates to:
  /// **'Grid view'**
  String get gridView;

  /// No description provided for @listView.
  ///
  /// In en, this message translates to:
  /// **'List view'**
  String get listView;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @noRecipesTitle.
  ///
  /// In en, this message translates to:
  /// **'No recipes found'**
  String get noRecipesTitle;

  /// No description provided for @noRecipesBody.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or clear your filters.'**
  String get noRecipesBody;

  /// No description provided for @filterRecipes.
  ///
  /// In en, this message translates to:
  /// **'Filter Recipes'**
  String get filterRecipes;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @diet.
  ///
  /// In en, this message translates to:
  /// **'Diet'**
  String get diet;

  /// No description provided for @anyDiet.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get anyDiet;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Minute} other{{count} Minutes}}'**
  String minutes(int count);

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String hours(int count);

  /// No description provided for @hoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String hoursMinutes(int hours, int minutes);

  /// No description provided for @stepsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Step} other{{count} Steps}}'**
  String stepsCount(int count);

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// No description provided for @savedRecipes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No saved recipes} =1{1 saved recipe} other{{count} saved recipes}}'**
  String savedRecipes(int count);

  /// No description provided for @noFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavoritesTitle;

  /// No description provided for @noFavoritesBody.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on any recipe to save it here.'**
  String get noFavoritesBody;

  /// No description provided for @historySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your progress over time'**
  String get historySubtitle;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challenges;

  /// No description provided for @beatTheClock.
  ///
  /// In en, this message translates to:
  /// **'Beat the clock'**
  String get beatTheClock;

  /// No description provided for @winRate.
  ///
  /// In en, this message translates to:
  /// **'Win rate'**
  String get winRate;

  /// No description provided for @noHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'No challenges yet'**
  String get noHistoryTitle;

  /// No description provided for @noHistoryBody.
  ///
  /// In en, this message translates to:
  /// **'Finish a recipe challenge to see it here.'**
  String get noHistoryBody;

  /// No description provided for @beatIt.
  ///
  /// In en, this message translates to:
  /// **'Beat it'**
  String get beatIt;

  /// No description provided for @overTime.
  ///
  /// In en, this message translates to:
  /// **'Over time'**
  String get overTime;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @forLevel.
  ///
  /// In en, this message translates to:
  /// **'For {level}'**
  String forLevel(String level);

  /// No description provided for @servings.
  ///
  /// In en, this message translates to:
  /// **'Servings'**
  String get servings;

  /// No description provided for @ingredientsCount.
  ///
  /// In en, this message translates to:
  /// **'Ingredients ({count})'**
  String ingredientsCount(int count);

  /// No description provided for @currentStep.
  ///
  /// In en, this message translates to:
  /// **'Current step'**
  String get currentStep;

  /// No description provided for @upNext.
  ///
  /// In en, this message translates to:
  /// **'Up next'**
  String get upNext;

  /// No description provided for @stepWord.
  ///
  /// In en, this message translates to:
  /// **'Step '**
  String get stepWord;

  /// No description provided for @ofTotal.
  ///
  /// In en, this message translates to:
  /// **' of {total}'**
  String ofTotal(int total);

  /// No description provided for @levelChallenge.
  ///
  /// In en, this message translates to:
  /// **'{level} challenge'**
  String levelChallenge(String level);

  /// No description provided for @quit.
  ///
  /// In en, this message translates to:
  /// **'Quit'**
  String get quit;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @quitTitle.
  ///
  /// In en, this message translates to:
  /// **'Quit challenge?'**
  String get quitTitle;

  /// No description provided for @quitBody.
  ///
  /// In en, this message translates to:
  /// **'Your progress for this run will be lost.'**
  String get quitBody;

  /// No description provided for @keepCooking.
  ///
  /// In en, this message translates to:
  /// **'Keep cooking'**
  String get keepCooking;

  /// No description provided for @currentTime.
  ///
  /// In en, this message translates to:
  /// **'Current Time'**
  String get currentTime;

  /// No description provided for @statusOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get statusOnTrack;

  /// No description provided for @statusAlmost.
  ///
  /// In en, this message translates to:
  /// **'Almost there'**
  String get statusAlmost;

  /// No description provided for @statusBitOver.
  ///
  /// In en, this message translates to:
  /// **'A bit over'**
  String get statusBitOver;

  /// No description provided for @statusLate.
  ///
  /// In en, this message translates to:
  /// **'Running late'**
  String get statusLate;

  /// No description provided for @statusWayOver.
  ///
  /// In en, this message translates to:
  /// **'Way over time'**
  String get statusWayOver;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// No description provided for @finishChallenge.
  ///
  /// In en, this message translates to:
  /// **'Finish Challenge'**
  String get finishChallenge;

  /// No description provided for @youBeatTheClock.
  ///
  /// In en, this message translates to:
  /// **'You Beat The Clock!'**
  String get youBeatTheClock;

  /// No description provided for @challengeComplete.
  ///
  /// In en, this message translates to:
  /// **'Challenge Complete'**
  String get challengeComplete;

  /// No description provided for @yourTime.
  ///
  /// In en, this message translates to:
  /// **'Your time'**
  String get yourTime;

  /// No description provided for @expected.
  ///
  /// In en, this message translates to:
  /// **'Expected'**
  String get expected;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'On time'**
  String get onTime;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @assistant.
  ///
  /// In en, this message translates to:
  /// **'Chef AI'**
  String get assistant;

  /// No description provided for @assistantSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask anything about any dish'**
  String get assistantSubtitle;

  /// No description provided for @askChef.
  ///
  /// In en, this message translates to:
  /// **'Ask Chef AI'**
  String get askChef;

  /// No description provided for @assistantHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about any dish…'**
  String get assistantHint;

  /// No description provided for @assistantEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'What are we cooking today?'**
  String get assistantEmptyTitle;

  /// No description provided for @assistantEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Ask how to cook a dish, what to swap, or how long it takes.'**
  String get assistantEmptyBody;

  /// No description provided for @suggestGeneral1.
  ///
  /// In en, this message translates to:
  /// **'How do I make molokhia like my grandma?'**
  String get suggestGeneral1;

  /// No description provided for @suggestGeneral2.
  ///
  /// In en, this message translates to:
  /// **'What can I cook with chicken and potatoes?'**
  String get suggestGeneral2;

  /// No description provided for @suggestGeneral3.
  ///
  /// In en, this message translates to:
  /// **'How do I keep rice from sticking?'**
  String get suggestGeneral3;

  /// No description provided for @suggestDish1.
  ///
  /// In en, this message translates to:
  /// **'What can I swap in {dish}?'**
  String suggestDish1(String dish);

  /// No description provided for @suggestDish2.
  ///
  /// In en, this message translates to:
  /// **'Tips to get {dish} right the first time?'**
  String suggestDish2(String dish);

  /// No description provided for @suggestDish3.
  ///
  /// In en, this message translates to:
  /// **'How do I serve {dish} for 8 people?'**
  String suggestDish3(String dish);

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @newChat.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get newChat;

  /// No description provided for @assistantThinking.
  ///
  /// In en, this message translates to:
  /// **'Cooking up an answer…'**
  String get assistantThinking;

  /// No description provided for @assistantSearching.
  ///
  /// In en, this message translates to:
  /// **'Searching the web for the right answer…'**
  String get assistantSearching;

  /// No description provided for @sources.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get sources;

  /// No description provided for @assistantNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Chef AI needs a Claude API key. Run the app with --dart-define=ANTHROPIC_API_KEY=your_key'**
  String get assistantNotConfigured;

  /// No description provided for @assistantErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach Chef AI. Check your connection and try again.'**
  String get assistantErrorNetwork;

  /// No description provided for @assistantErrorApi.
  ///
  /// In en, this message translates to:
  /// **'Chef AI couldn\'t answer right now ({detail}).'**
  String assistantErrorApi(String detail);

  /// No description provided for @assistantErrorRefusal.
  ///
  /// In en, this message translates to:
  /// **'Chef AI can\'t help with that one. Try another cooking question.'**
  String get assistantErrorRefusal;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
