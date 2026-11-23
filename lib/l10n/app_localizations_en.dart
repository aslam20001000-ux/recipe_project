// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Recipe Challenge';

  @override
  String get language => 'Language';

  @override
  String get languageName => 'English';

  @override
  String get skip => 'Skip';

  @override
  String get introTitlePrefix => 'Master Your ';

  @override
  String get introTitleHighlight => 'Cooking Time';

  @override
  String get introBody =>
      'Turn cooking into an exciting challenge. Race against time, improve your skills, and become a kitchen champion!';

  @override
  String get tellMeMore => 'Tell Me More';

  @override
  String get featuresTitlePrefix => 'Cook, Compete, ';

  @override
  String get featuresTitleHighlight => 'Conquer';

  @override
  String get featureTimeTitle => 'Time Each Step';

  @override
  String get featureTimeBody => 'Follow recipe steps with built-in timers';

  @override
  String get featureClockTitle => 'Beat The Clock';

  @override
  String get featureClockBody => 'Match or beat expected cooking times';

  @override
  String get featureProgressTitle => 'Track Progress';

  @override
  String get featureProgressBody => 'See your improvement over time';

  @override
  String get iAmReady => 'I Am Ready';

  @override
  String get levelTitlePrefix => 'What\'s Your ';

  @override
  String get levelTitleHighlight => 'Cooking Level?';

  @override
  String get levelSubtitle =>
      'Help us customize your experience and set appropriate challenges';

  @override
  String get enterName => 'Enter your name';

  @override
  String get letsGo => 'Let\'s Go!';

  @override
  String get levelBeginner => 'Beginner';

  @override
  String get levelBeginnerDesc => 'Just starting';

  @override
  String get levelIntermediate => 'Intermediate';

  @override
  String get levelIntermediateDesc => 'Cooks often, knows a few recipes';

  @override
  String get levelChef => 'Chef';

  @override
  String get levelChefDesc => 'Let me cook!';

  @override
  String get dietMeat => 'Meat based';

  @override
  String get dietPlant => 'Plant based';

  @override
  String get greetingMorning => 'Good Morning';

  @override
  String get greetingAfternoon => 'Good Afternoon';

  @override
  String get greetingEvening => 'Good Evening';

  @override
  String get greetingNight => 'Good Night';

  @override
  String get nameSeparator => ', ';

  @override
  String get readyToCook => 'Ready to cook something amazing?';

  @override
  String get changeCookLevel => 'Change cook level';

  @override
  String get todaysChallenge => 'Today\'s Challenge';

  @override
  String get startChallenge => 'Start Challenge';

  @override
  String get randomRecipe => 'Random Recipe';

  @override
  String get randomRecipeBody => 'Don\'t know what to cook?';

  @override
  String get recipes => 'Recipes';

  @override
  String get searchHint => 'Search for a recipe...';

  @override
  String get gridView => 'Grid view';

  @override
  String get listView => 'List view';

  @override
  String get filter => 'Filter';

  @override
  String get noRecipesTitle => 'No recipes found';

  @override
  String get noRecipesBody => 'Try a different search or clear your filters.';

  @override
  String get filterRecipes => 'Filter Recipes';

  @override
  String get reset => 'Reset';

  @override
  String get diet => 'Diet';

  @override
  String get anyDiet => 'Any';

  @override
  String get tags => 'Tags';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String minutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Minutes',
      one: '1 Minute',
    );
    return '$_temp0';
  }

  @override
  String hours(int count) {
    return '${count}h';
  }

  @override
  String hoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String stepsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Steps',
      one: '1 Step',
    );
    return '$_temp0';
  }

  @override
  String get explore => 'Explore';

  @override
  String get favorites => 'Favorites';

  @override
  String get history => 'History';

  @override
  String get addToFavorites => 'Add to favorites';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String savedRecipes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saved recipes',
      one: '1 saved recipe',
      zero: 'No saved recipes',
    );
    return '$_temp0';
  }

  @override
  String get noFavoritesTitle => 'No favorites yet';

  @override
  String get noFavoritesBody => 'Tap the heart on any recipe to save it here.';

  @override
  String get historySubtitle => 'Track your progress over time';

  @override
  String get challenges => 'Challenges';

  @override
  String get beatTheClock => 'Beat the clock';

  @override
  String get winRate => 'Win rate';

  @override
  String get noHistoryTitle => 'No challenges yet';

  @override
  String get noHistoryBody => 'Finish a recipe challenge to see it here.';

  @override
  String get beatIt => 'Beat it';

  @override
  String get overTime => 'Over time';

  @override
  String get back => 'Back';

  @override
  String get overview => 'Overview';

  @override
  String get steps => 'Steps';

  @override
  String forLevel(String level) {
    return 'For $level';
  }

  @override
  String get servings => 'Servings';

  @override
  String ingredientsCount(int count) {
    return 'Ingredients ($count)';
  }

  @override
  String get currentStep => 'Current step';

  @override
  String get upNext => 'Up next';

  @override
  String get stepWord => 'Step ';

  @override
  String ofTotal(int total) {
    return ' of $total';
  }

  @override
  String levelChallenge(String level) {
    return '$level challenge';
  }

  @override
  String get quit => 'Quit';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get quitTitle => 'Quit challenge?';

  @override
  String get quitBody => 'Your progress for this run will be lost.';

  @override
  String get keepCooking => 'Keep cooking';

  @override
  String get currentTime => 'Current Time';

  @override
  String get statusOnTrack => 'On track';

  @override
  String get statusAlmost => 'Almost there';

  @override
  String get statusBitOver => 'A bit over';

  @override
  String get statusLate => 'Running late';

  @override
  String get statusWayOver => 'Way over time';

  @override
  String get timeline => 'Timeline';

  @override
  String get nextStep => 'Next Step';

  @override
  String get finishChallenge => 'Finish Challenge';

  @override
  String get youBeatTheClock => 'You Beat The Clock!';

  @override
  String get challengeComplete => 'Challenge Complete';

  @override
  String get yourTime => 'Your time';

  @override
  String get expected => 'Expected';

  @override
  String get onTime => 'On time';

  @override
  String get done => 'Done';

  @override
  String get assistant => 'Chef AI';

  @override
  String get assistantSubtitle => 'Ask anything about any dish';

  @override
  String get askChef => 'Ask Chef AI';

  @override
  String get assistantHint => 'Ask about any dish…';

  @override
  String get assistantEmptyTitle => 'What are we cooking today?';

  @override
  String get assistantEmptyBody =>
      'Ask how to cook a dish, what to swap, or how long it takes.';

  @override
  String get suggestGeneral1 => 'How do I make molokhia like my grandma?';

  @override
  String get suggestGeneral2 => 'What can I cook with chicken and potatoes?';

  @override
  String get suggestGeneral3 => 'How do I keep rice from sticking?';

  @override
  String suggestDish1(String dish) {
    return 'What can I swap in $dish?';
  }

  @override
  String suggestDish2(String dish) {
    return 'Tips to get $dish right the first time?';
  }

  @override
  String suggestDish3(String dish) {
    return 'How do I serve $dish for 8 people?';
  }

  @override
  String get send => 'Send';

  @override
  String get stop => 'Stop';

  @override
  String get newChat => 'New chat';

  @override
  String get assistantThinking => 'Cooking up an answer…';

  @override
  String get assistantSearching => 'Searching the web for the right answer…';

  @override
  String get sources => 'Sources';

  @override
  String get assistantNotConfigured =>
      'Chef AI needs a Claude API key. Run the app with --dart-define=ANTHROPIC_API_KEY=your_key';

  @override
  String get assistantErrorNetwork =>
      'Couldn\'t reach Chef AI. Check your connection and try again.';

  @override
  String assistantErrorApi(String detail) {
    return 'Chef AI couldn\'t answer right now ($detail).';
  }

  @override
  String get assistantErrorRefusal =>
      'Chef AI can\'t help with that one. Try another cooking question.';
}
