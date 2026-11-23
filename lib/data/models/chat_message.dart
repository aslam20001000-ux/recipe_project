import 'package:flutter/foundation.dart';

enum ChatRole { user, assistant }

/// A web page an answer was based on.
@immutable
class WebSource {
  const WebSource({required this.title, required this.url});

  final String title;
  final String url;

  /// Short site name for display, e.g. "example.com".
  String get site {
    final host = Uri.tryParse(url)?.host ?? url;
    return host.startsWith('www.') ? host.substring(4) : host;
  }

  @override
  bool operator ==(Object other) =>
      other is WebSource && other.url == url && other.title == title;

  @override
  int get hashCode => Object.hash(title, url);
}

/// One immutable line of the assistant conversation.
@immutable
class ChatMessage {
  const ChatMessage({
    required this.role,
    required this.text,
    this.isError = false,
    this.sources = const [],
  });

  final ChatRole role;
  final String text;

  /// True when the reply failed; failed turns are not sent back to the model.
  final bool isError;

  /// Web pages the reply cites (empty when it came from the app's data).
  final List<WebSource> sources;

  bool get isUser => role == ChatRole.user;

  ChatMessage copyWith({
    String? text,
    bool? isError,
    List<WebSource>? sources,
  }) => ChatMessage(
    role: role,
    text: text ?? this.text,
    isError: isError ?? this.isError,
    sources: sources ?? this.sources,
  );

  @override
  bool operator ==(Object other) =>
      other is ChatMessage &&
      other.role == role &&
      other.text == text &&
      other.isError == isError &&
      listEquals(other.sources, sources);

  @override
  int get hashCode => Object.hash(role, text, isError, Object.hashAll(sources));
}
