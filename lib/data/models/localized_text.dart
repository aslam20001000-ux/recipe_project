import 'package:flutter/widgets.dart';

/// A piece of content text available in every supported language.
///
/// UI strings (buttons, titles…) live in the ARB files under `lib/l10n`;
/// this class is for *data* such as recipe names and steps.
@immutable
class LocalizedText {
  const LocalizedText(this.en, this.ar);

  final String en;
  final String ar;

  String of(Locale locale) => locale.languageCode == 'ar' ? ar : en;

  /// True if any translation contains [query] (case-insensitive).
  bool contains(String query) {
    final q = query.toLowerCase();
    return en.toLowerCase().contains(q) || ar.contains(q);
  }

  @override
  bool operator ==(Object other) =>
      other is LocalizedText && other.en == en && other.ar == ar;

  @override
  int get hashCode => Object.hash(en, ar);

  @override
  String toString() => en;
}

extension LocalizedTextContext on BuildContext {
  /// Resolves [text] for the current app locale.
  String tr(LocalizedText text) => text.of(Localizations.localeOf(this));
}
