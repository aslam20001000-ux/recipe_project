import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/models/chat_message.dart';
import '../services/chef_assistant.dart';

/// Screen-scoped state of one assistant conversation.
///
/// Holds the messages and whether a reply is streaming. The context
/// (user, level, language, current recipe) is read fresh on every send.
class ChatController extends ChangeNotifier {
  ChatController(this._assistant);

  final ChefAssistant _assistant;
  final List<ChatMessage> _messages = [];
  StreamSubscription<AssistantEvent>? _subscription;
  AssistantException? _lastError;
  bool _searching = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isReplying => _subscription != null;

  /// The reply is waiting on a web search (the app's data didn't cover it).
  bool get isSearching => isReplying && _searching;
  bool get isConfigured => _assistant.isConfigured;

  /// Why the last reply failed (the failed bubble shows a message for it).
  AssistantException? get lastError => _lastError;

  /// Conversation sent to the model: failed turns and their questions are
  /// left out so roles keep alternating user / assistant.
  List<ChatMessage> get _history {
    final result = <ChatMessage>[];
    for (final m in _messages) {
      if (m.isError) {
        if (result.isNotEmpty && result.last.isUser) result.removeLast();
        continue;
      }
      result.add(m);
    }
    return result;
  }

  void send(String text, AssistantContext context) {
    final question = text.trim();
    if (question.isEmpty || isReplying) return;

    _lastError = null;
    _searching = false;
    _messages.add(ChatMessage(role: ChatRole.user, text: question));
    final history = _history;
    _messages.add(const ChatMessage(role: ChatRole.assistant, text: ''));
    notifyListeners();

    _subscription = _assistant
        .reply(history: history, context: context)
        .listen(
          (event) {
            switch (event) {
              case TextChunk(:final text):
                _searching = false;
                _updateLast((m) => m.copyWith(text: m.text + text));
              case SearchingWeb():
                _searching = true;
                notifyListeners();
              case SourcesFound(:final sources):
                _updateLast((m) => m.copyWith(sources: sources));
            }
          },
          onError: (Object e) {
            _lastError = e is AssistantException
                ? e
                : AssistantException(AssistantErrorKind.network, '$e');
            // A partial reply cut off by an error is discarded.
            _updateLast((m) => m.copyWith(text: '', isError: true));
            _finish();
          },
          onDone: _finish,
          cancelOnError: true,
        );
  }

  /// Stops the reply that is streaming; keeps what arrived so far.
  void stop() {
    if (!isReplying) return;
    _subscription!.cancel();
    // Nothing arrived yet: drop the unanswered question with it.
    if (_messages.last.text.isEmpty) {
      _messages.removeRange(_messages.length - 2, _messages.length);
    }
    _subscription = null;
    notifyListeners();
  }

  void clear() {
    _subscription?.cancel();
    _subscription = null;
    _lastError = null;
    _messages.clear();
    notifyListeners();
  }

  void _updateLast(ChatMessage Function(ChatMessage) update) {
    _messages[_messages.length - 1] = update(_messages.last);
    notifyListeners();
  }

  void _finish() {
    _subscription = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
