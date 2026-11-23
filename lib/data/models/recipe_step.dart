import 'package:flutter/foundation.dart';

import 'cook_level.dart';
import 'localized_text.dart';

/// One step of a recipe.
///
/// [baseDuration] is the expected time for an intermediate cook. The time the
/// user is actually given depends on their [CookLevel] (see [durationFor]).
@immutable
class RecipeStep {
  const RecipeStep({
    required this.title,
    required this.description,
    required this.baseDuration,
  });

  final LocalizedText title;
  final LocalizedText description;
  final Duration baseDuration;

  /// Expected duration of this step, scaled by the cook level factor.
  Duration durationFor(CookLevel level) => baseDuration * level.timeFactor;

  @override
  bool operator ==(Object other) =>
      other is RecipeStep &&
      other.title == title &&
      other.description == description &&
      other.baseDuration == baseDuration;

  @override
  int get hashCode => Object.hash(title, description, baseDuration);
}
