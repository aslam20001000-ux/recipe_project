import 'package:flutter/foundation.dart';

import '../data/models/cook_level.dart';

/// Shared state about the user, gathered during onboarding.
///
/// Pure state: [name], [level], [hasOnboarded].
/// Everything else (greeting, per-level times) is inferred from it.
class UserController extends ChangeNotifier {
  String _name = '';
  CookLevel _level = CookLevel.intermediate;
  bool _hasOnboarded = false;

  String get name => _name;
  CookLevel get level => _level;
  bool get hasOnboarded => _hasOnboarded;

  void completeOnboarding({required String name, required CookLevel level}) {
    _name = name.trim();
    _level = level;
    _hasOnboarded = true;
    notifyListeners();
  }

  void setLevel(CookLevel level) {
    if (level == _level) return;
    _level = level;
    notifyListeners();
  }
}
