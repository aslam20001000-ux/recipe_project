import 'package:flutter/foundation.dart';

import '../data/models/challenge_result.dart';

/// Shared state: the list of finished challenges, newest first.
class HistoryController extends ChangeNotifier {
  final List<ChallengeResult> _results = [];

  List<ChallengeResult> get results => List.unmodifiable(_results);

  int get totalChallenges => _results.length;

  int get wins => _results.where((r) => r.beatTheClock).length;

  void add(ChallengeResult result) {
    _results.insert(0, result);
    notifyListeners();
  }
}
