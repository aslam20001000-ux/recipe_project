import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/models/challenge_result.dart';
import '../data/models/cook_level.dart';
import '../data/models/recipe.dart';
import '../data/models/recipe_step.dart';

/// Ephemeral state of one running recipe challenge.
///
/// Created when the challenge screen opens and disposed when it closes.
/// Pure state is the current step index, the recorded times of finished steps
/// and the elapsed time of the current step. Progress ratios and the
/// timeline are inferred from those.
class ChallengeController extends ChangeNotifier {
  ChallengeController({
    required this.recipe,
    required this.level,
    this.speed = 1,
  }) : expectedTimes = List.unmodifiable(
         recipe.steps.map((s) => s.durationFor(level)),
       ) {
    _start();
  }

  static const _tick = Duration(milliseconds: 200);

  final Recipe recipe;
  final CookLevel level;
  final List<Duration> expectedTimes;

  /// Time multiplier, useful to demo the challenge quickly (debug only).
  double speed;

  final List<Duration> _recordedTimes = [];
  int _currentIndex = 0;
  Duration _stepElapsed = Duration.zero;
  bool _isPaused = false;
  bool _isFinished = false;
  Timer? _timer;

  int get currentIndex => _currentIndex;
  int get stepCount => recipe.stepCount;
  bool get isPaused => _isPaused;
  bool get isFinished => _isFinished;
  bool get isLastStep => _currentIndex == stepCount - 1;
  List<Duration> get recordedTimes => List.unmodifiable(_recordedTimes);

  RecipeStep get currentStep => recipe.steps[_currentIndex];
  RecipeStep? get nextStep =>
      isLastStep ? null : recipe.steps[_currentIndex + 1];

  Duration get stepElapsed => _stepElapsed;
  Duration get stepExpected => expectedTimes[_currentIndex];

  /// Elapsed / expected for the current step. Above 1 means overtime.
  double get stepRatio => _ratio(_stepElapsed, stepExpected);

  Duration get totalExpected =>
      expectedTimes.fold(Duration.zero, (a, b) => a + b);

  Duration get totalElapsed =>
      _recordedTimes.fold(Duration.zero, (a, b) => a + b) + _stepElapsed;

  /// Elapsed time of step [index]: recorded, live, or zero for upcoming.
  Duration elapsedForStep(int index) {
    if (index < _recordedTimes.length) return _recordedTimes[index];
    if (index == _currentIndex && !_isFinished) return _stepElapsed;
    return Duration.zero;
  }

  void _start() {
    _timer = Timer.periodic(_tick, (_) {
      if (_isPaused || _isFinished) return;
      _stepElapsed += _tick * speed;
      notifyListeners();
    });
  }

  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  void setSpeed(double value) {
    speed = value;
    notifyListeners();
  }

  /// Records the current step and moves to the next one, or finishes.
  void completeStep() {
    if (_isFinished) return;
    _recordedTimes.add(_stepElapsed);
    if (isLastStep) {
      _isFinished = true;
      _timer?.cancel();
    } else {
      _currentIndex++;
      _stepElapsed = Duration.zero;
    }
    notifyListeners();
  }

  ChallengeResult buildResult() => ChallengeResult(
    recipeId: recipe.id,
    recipeName: recipe.name,
    imageUrl: recipe.imageUrl,
    level: level,
    actualStepTimes: _recordedTimes,
    expectedStepTimes: expectedTimes,
    completedAt: DateTime.now(),
  );

  static double _ratio(Duration elapsed, Duration expected) {
    if (expected == Duration.zero) return 0;
    return elapsed.inMilliseconds / expected.inMilliseconds;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
