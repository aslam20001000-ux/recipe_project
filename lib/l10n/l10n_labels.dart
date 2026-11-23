import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../data/models/cook_level.dart';
import '../data/models/diet_type.dart';
import 'app_localizations.dart';

export 'app_localizations.dart';
export '../data/models/localized_text.dart' show LocalizedTextContext;

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension CookLevelL10n on CookLevel {
  String label(AppLocalizations l) => switch (this) {
    CookLevel.beginner => l.levelBeginner,
    CookLevel.intermediate => l.levelIntermediate,
    CookLevel.chef => l.levelChef,
  };

  String description(AppLocalizations l) => switch (this) {
    CookLevel.beginner => l.levelBeginnerDesc,
    CookLevel.intermediate => l.levelIntermediateDesc,
    CookLevel.chef => l.levelChefDesc,
  };
}

extension DietTypeL10n on DietType {
  String label(AppLocalizations l) => switch (this) {
    DietType.meat => l.dietMeat,
    DietType.plant => l.dietPlant,
  };
}

/// "40 Minutes" / "٤٠ دقيقة", or "1h 15m" past an hour.
String formatMinutes(Duration d, AppLocalizations l) {
  final minutes = (d.inSeconds / 60).round();
  if (minutes >= 60) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? l.hours(h) : l.hoursMinutes(h, m);
  }
  return l.minutes(minutes);
}

/// Greeting that depends on the time of day.
String greetingFor(DateTime now, AppLocalizations l) {
  final hour = now.hour;
  if (hour >= 5 && hour < 12) return l.greetingMorning;
  if (hour >= 12 && hour < 17) return l.greetingAfternoon;
  if (hour >= 17 && hour < 22) return l.greetingEvening;
  return l.greetingNight;
}

String formatDate(DateTime d, Locale locale) =>
    DateFormat('MMM d, HH:mm', locale.toLanguageTag()).format(d);
