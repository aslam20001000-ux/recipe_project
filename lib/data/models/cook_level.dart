/// The user's cooking experience.
///
/// Each level carries a [timeFactor] that scales the expected duration of
/// every recipe step: beginners get more time, chefs get less.
/// Display names are localized in `lib/l10n/l10n_labels.dart`.
enum CookLevel {
  beginner(emoji: '🍳', timeFactor: 1.5),
  intermediate(emoji: '👨‍🍳', timeFactor: 1.0),
  chef(emoji: '🔥', timeFactor: 0.75);

  const CookLevel({required this.emoji, required this.timeFactor});

  final String emoji;
  final double timeFactor;
}
