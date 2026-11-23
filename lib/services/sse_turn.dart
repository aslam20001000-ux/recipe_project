import 'dart:convert';

import '../data/models/chat_message.dart';

/// Rebuilds the assistant's content blocks from streamed SSE events.
///
/// Needed for `pause_turn`: when the server-side search loop pauses, the
/// assistant content must be sent back exactly as produced (search calls,
/// results, thinking signatures) so the API can resume it.
class SseTurn {
  final _blocks = <int, Map<String, dynamic>>{};
  final _partialJson = <int, StringBuffer>{};
  final _sources = <String, WebSource>{};

  String? stopReason;

  List<Map<String, dynamic>> get content {
    final keys = _blocks.keys.toList()..sort();
    return [for (final k in keys) _blocks[k]!];
  }

  List<WebSource> get sources => _sources.values.toList();

  void start(int index, Map<String, dynamic> block) {
    _blocks[index] = Map.of(block);
  }

  void delta(int index, Map<String, dynamic> delta) {
    final block = _blocks[index];
    if (block == null) return;
    switch (delta['type']) {
      case 'text_delta':
        block['text'] = '${block['text'] ?? ''}${delta['text']}';
      case 'thinking_delta':
        block['thinking'] = '${block['thinking'] ?? ''}${delta['thinking']}';
      case 'signature_delta':
        block['signature'] = delta['signature'];
      case 'input_json_delta':
        (_partialJson[index] ??= StringBuffer()).write(delta['partial_json']);
      case 'citations_delta':
        final citation = delta['citation'];
        (block['citations'] ??= <dynamic>[]).add(citation);
        if (citation is Map && citation['url'] is String) {
          final url = citation['url'] as String;
          _sources[url] = WebSource(
            title: (citation['title'] as String?) ?? url,
            url: url,
          );
        }
    }
  }

  /// Finishes a block; returns it so callers can react to finished tool calls.
  Map<String, dynamic>? stop(int index) {
    final block = _blocks[index];
    final json = _partialJson.remove(index)?.toString();
    if (block != null && json != null) {
      block['input'] = json.isEmpty ? <String, dynamic>{} : jsonDecode(json);
    }
    return block;
  }
}
