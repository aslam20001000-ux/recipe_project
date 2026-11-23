import '../data/models/chat_message.dart';

/// What the assistant stream emits while it builds a reply.
sealed class AssistantEvent {
  const AssistantEvent();
}

/// More reply text.
final class TextChunk extends AssistantEvent {
  const TextChunk(this.text);
  final String text;
}

/// The assistant is searching the web (for things the app doesn't know).
final class SearchingWeb extends AssistantEvent {
  const SearchingWeb(this.query);
  final String? query;
}

/// Pages the reply was based on.
final class SourcesFound extends AssistantEvent {
  const SourcesFound(this.sources);
  final List<WebSource> sources;
}
