import 'package:recipe_project/data/models/chat_message.dart';
import 'package:recipe_project/services/chef_assistant.dart';

/// Replies with a fixed answer, streamed word by word, and records requests.
/// With [sources] set it pretends to search the web first.
class FakeAssistant implements ChefAssistant {
  FakeAssistant({
    this.answer = 'Soak the rice for 20 minutes first.',
    this.sources = const [],
  });

  final String answer;
  final List<WebSource> sources;
  final requests = <(List<ChatMessage>, AssistantContext)>[];
  Object? failWith;

  @override
  bool get isConfigured => true;

  @override
  Stream<AssistantEvent> reply({
    required List<ChatMessage> history,
    required AssistantContext context,
  }) async* {
    requests.add((history, context));
    final error = failWith;
    if (error != null) throw error;
    if (sources.isNotEmpty) {
      yield const SearchingWeb('query');
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
    for (final word in answer.split(' ')) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
      yield TextChunk('$word ');
    }
    if (sources.isNotEmpty) yield SourcesFound(sources);
  }
}
