import 'package:flutter/foundation.dart';

import 'localized_text.dart';

/// A single ingredient line of a recipe, e.g. "200 g · Chicken breast".
@immutable
class Ingredient {
  const Ingredient({required this.name, required this.quantity});

  final LocalizedText name;
  final LocalizedText quantity;

  @override
  bool operator ==(Object other) =>
      other is Ingredient && other.name == name && other.quantity == quantity;

  @override
  int get hashCode => Object.hash(name, quantity);
}
