import 'package:flutter/foundation.dart';

import 'cook_level.dart';
import 'localized_text.dart';

/// The outcome of a finished recipe challenge, stored in the history.
@immutable
class ChallengeResult {
  ChallengeResult({
    required this.recipeId,
    required this.recipeName,
    required this.imageUrl,
    required this.level,
    required List<Duration> actualStepTimes,
    required List<Duration> expectedStepTimes,
    required this.completedAt,
  }) : actualStepTimes = List.unmodifiable(actualStepTimes),
       expectedStepTimes = List.unmodifiable(expectedStepTimes);

  final String recipeId;
  final LocalizedText recipeName;
  final String imageUrl;
  final CookLevel level;
  final List<Duration> actualStepTimes;
  final List<Duration> expectedStepTimes;
  final DateTime completedAt;

  Duration get actualTotal =>
      actualStepTimes.fold(Duration.zero, (a, b) => a + b);

  Duration get expectedTotal =>
      expectedStepTimes.fold(Duration.zero, (a, b) => a + b);

  /// True when the user finished within the expected time.
  bool get beatTheClock => actualTotal <= expectedTotal;

  /// Number of steps that were finished on time.
  int get stepsOnTime {
    var count = 0;
    for (var i = 0; i < actualStepTimes.length; i++) {
      if (actualStepTimes[i] <= expectedStepTimes[i]) count++;
    }
    return count;
  }
}
