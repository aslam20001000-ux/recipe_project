// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تحدي الوصفات';

  @override
  String get language => 'اللغة';

  @override
  String get languageName => 'العربية';

  @override
  String get skip => 'تخطي';

  @override
  String get introTitlePrefix => 'اتحكم في ';

  @override
  String get introTitleHighlight => 'وقت طبخك';

  @override
  String get introBody =>
      'حوّل الطبخ لتحدي ممتع. سابق الوقت، طوّر مهاراتك، وبقى بطل المطبخ!';

  @override
  String get tellMeMore => 'قولي أكتر';

  @override
  String get featuresTitlePrefix => 'اطبخ، نافس، ';

  @override
  String get featuresTitleHighlight => 'واكسب';

  @override
  String get featureTimeTitle => 'وقّت كل خطوة';

  @override
  String get featureTimeBody => 'امشي على خطوات الوصفة بمؤقت جاهز';

  @override
  String get featureClockTitle => 'اسبق الوقت';

  @override
  String get featureClockBody => 'خلّص في الوقت المتوقع أو أسرع';

  @override
  String get featureProgressTitle => 'تابع تقدمك';

  @override
  String get featureProgressBody => 'شوف تطورك مع الوقت';

  @override
  String get iAmReady => 'أنا جاهز';

  @override
  String get levelTitlePrefix => 'إيه ';

  @override
  String get levelTitleHighlight => 'مستواك في الطبخ؟';

  @override
  String get levelSubtitle => 'ساعدنا نظبط التجربة ونختارلك تحديات مناسبة';

  @override
  String get enterName => 'اكتب اسمك';

  @override
  String get letsGo => 'يلا بينا!';

  @override
  String get levelBeginner => 'مبتدئ';

  @override
  String get levelBeginnerDesc => 'لسه ببدأ';

  @override
  String get levelIntermediate => 'متوسط';

  @override
  String get levelIntermediateDesc => 'بطبخ كتير وعارف كام وصفة';

  @override
  String get levelChef => 'شيف';

  @override
  String get levelChefDesc => 'سيبني أطبخ!';

  @override
  String get dietMeat => 'فيه لحوم';

  @override
  String get dietPlant => 'نباتي';

  @override
  String get greetingMorning => 'صباح الخير';

  @override
  String get greetingAfternoon => 'نهارك سعيد';

  @override
  String get greetingEvening => 'مساء الخير';

  @override
  String get greetingNight => 'تصبح على خير';

  @override
  String get nameSeparator => '، ';

  @override
  String get readyToCook => 'جاهز تطبخ حاجة تحفة؟';

  @override
  String get changeCookLevel => 'غيّر مستوى الطبخ';

  @override
  String get todaysChallenge => 'تحدي النهارده';

  @override
  String get startChallenge => 'ابدأ التحدي';

  @override
  String get randomRecipe => 'وصفة عشوائية';

  @override
  String get randomRecipeBody => 'مش عارف تطبخ إيه؟';

  @override
  String get recipes => 'الوصفات';

  @override
  String get searchHint => 'دوّر على وصفة...';

  @override
  String get gridView => 'عرض شبكي';

  @override
  String get listView => 'عرض قائمة';

  @override
  String get filter => 'فلترة';

  @override
  String get noRecipesTitle => 'مفيش وصفات';

  @override
  String get noRecipesBody => 'جرّب كلمة تانية أو امسح الفلاتر.';

  @override
  String get filterRecipes => 'فلترة الوصفات';

  @override
  String get reset => 'مسح';

  @override
  String get diet => 'النوع';

  @override
  String get anyDiet => 'الكل';

  @override
  String get tags => 'التصنيفات';

  @override
  String get applyFilters => 'تطبيق الفلاتر';

  @override
  String minutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دقيقة',
      few: '$count دقائق',
      two: 'دقيقتين',
      one: 'دقيقة',
    );
    return '$_temp0';
  }

  @override
  String hours(int count) {
    return '$count س';
  }

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours س $minutes د';
  }

  @override
  String stepsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count خطوة',
      few: '$count خطوات',
      two: 'خطوتين',
      one: 'خطوة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get explore => 'استكشف';

  @override
  String get favorites => 'المفضلة';

  @override
  String get history => 'السجل';

  @override
  String get addToFavorites => 'ضيف للمفضلة';

  @override
  String get removeFromFavorites => 'شيل من المفضلة';

  @override
  String savedRecipes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count وصفة محفوظة',
      few: '$count وصفات محفوظة',
      two: 'وصفتين محفوظين',
      one: 'وصفة محفوظة',
      zero: 'مفيش وصفات محفوظة',
    );
    return '$_temp0';
  }

  @override
  String get noFavoritesTitle => 'لسه مفيش مفضلة';

  @override
  String get noFavoritesBody => 'دوس على القلب في أي وصفة عشان تحفظها هنا.';

  @override
  String get historySubtitle => 'تابع تقدمك مع الوقت';

  @override
  String get challenges => 'التحديات';

  @override
  String get beatTheClock => 'سبقت الوقت';

  @override
  String get winRate => 'نسبة الفوز';

  @override
  String get noHistoryTitle => 'لسه مفيش تحديات';

  @override
  String get noHistoryBody => 'خلّص تحدي وصفة عشان يظهر هنا.';

  @override
  String get beatIt => 'سبقته';

  @override
  String get overTime => 'اتأخرت';

  @override
  String get back => 'رجوع';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get steps => 'الخطوات';

  @override
  String forLevel(String level) {
    return 'لمستوى $level';
  }

  @override
  String get servings => 'أفراد';

  @override
  String ingredientsCount(int count) {
    return 'المكونات ($count)';
  }

  @override
  String get currentStep => 'الخطوة الحالية';

  @override
  String get upNext => 'اللي بعدها';

  @override
  String get stepWord => 'الخطوة ';

  @override
  String ofTotal(int total) {
    return ' من $total';
  }

  @override
  String levelChallenge(String level) {
    return 'تحدي $level';
  }

  @override
  String get quit => 'خروج';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get resume => 'كمّل';

  @override
  String get quitTitle => 'تخرج من التحدي؟';

  @override
  String get quitBody => 'تقدمك في المحاولة دي هيضيع.';

  @override
  String get keepCooking => 'كمّل طبخ';

  @override
  String get currentTime => 'الوقت الحالي';

  @override
  String get statusOnTrack => 'ماشي تمام';

  @override
  String get statusAlmost => 'قربت تخلص';

  @override
  String get statusBitOver => 'عديت شوية';

  @override
  String get statusLate => 'متأخر';

  @override
  String get statusWayOver => 'متأخر جدًا';

  @override
  String get timeline => 'الخط الزمني';

  @override
  String get nextStep => 'الخطوة الجاية';

  @override
  String get finishChallenge => 'خلّص التحدي';

  @override
  String get youBeatTheClock => 'سبقت الوقت!';

  @override
  String get challengeComplete => 'التحدي خلص';

  @override
  String get yourTime => 'وقتك';

  @override
  String get expected => 'المتوقع';

  @override
  String get onTime => 'في الوقت';

  @override
  String get done => 'تمام';

  @override
  String get assistant => 'الشيف الذكي';

  @override
  String get assistantSubtitle => 'اسأل أي سؤال عن أي أكلة';

  @override
  String get askChef => 'اسأل الشيف الذكي';

  @override
  String get assistantHint => 'اسأل عن أي أكلة…';

  @override
  String get assistantEmptyTitle => 'هنطبخ إيه النهارده؟';

  @override
  String get assistantEmptyBody =>
      'اسأل إزاي تعمل أكلة، تبدّل إيه بإيه، أو تاخد وقت قد إيه.';

  @override
  String get suggestGeneral1 => 'أعمل الملوخية إزاي زي بتاعة تيتة؟';

  @override
  String get suggestGeneral2 => 'أطبخ إيه بفراخ وبطاطس؟';

  @override
  String get suggestGeneral3 => 'إزاي الرز ما يلزقش؟';

  @override
  String suggestDish1(String dish) {
    return 'أقدر أبدّل إيه في $dish؟';
  }

  @override
  String suggestDish2(String dish) {
    return 'نصايح عشان $dish تطلع مظبوطة من أول مرة؟';
  }

  @override
  String suggestDish3(String dish) {
    return 'أعمل $dish لـ 8 أفراد إزاي؟';
  }

  @override
  String get send => 'ابعت';

  @override
  String get stop => 'وقّف';

  @override
  String get newChat => 'محادثة جديدة';

  @override
  String get assistantThinking => 'بحضّرلك الإجابة…';

  @override
  String get assistantSearching => 'بدوّر على النت على الإجابة الصح…';

  @override
  String get sources => 'المصادر';

  @override
  String get assistantNotConfigured =>
      'الشيف الذكي محتاج مفتاح Claude API. شغّل التطبيق بـ --dart-define=ANTHROPIC_API_KEY=your_key';

  @override
  String get assistantErrorNetwork =>
      'مش قادر أوصل للشيف الذكي. اتأكد من النت وجرّب تاني.';

  @override
  String assistantErrorApi(String detail) {
    return 'الشيف الذكي مش قادر يرد دلوقتي ($detail).';
  }

  @override
  String get assistantErrorRefusal =>
      'الشيف الذكي مش هيقدر يساعد في ده. جرّب سؤال تاني عن الطبخ.';
}
