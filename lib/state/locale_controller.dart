import 'package:flutter/widgets.dart';

/// Shared state: the app language chosen by the user.
///
/// `null` means "follow the device language".
class LocaleController extends ChangeNotifier {
  LocaleController({Locale? initial}) : _locale = initial;

  static const supported = [Locale('en'), Locale('ar')];

  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (locale == _locale) return;
    _locale = locale;
    notifyListeners();
  }
}
