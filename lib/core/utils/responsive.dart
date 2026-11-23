import 'package:flutter/widgets.dart';

/// Window size classes used across the app for adaptive layouts.
enum WindowSize { compact, medium, expanded }

abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 1000;

  /// Max width of content on very large screens.
  static const double maxContentWidth = 1200;

  static WindowSize of(double width) {
    if (width >= expanded) return WindowSize.expanded;
    if (width >= medium) return WindowSize.medium;
    return WindowSize.compact;
  }
}

extension ResponsiveContext on BuildContext {
  WindowSize get windowSize => Breakpoints.of(MediaQuery.sizeOf(this).width);

  bool get isCompact => windowSize == WindowSize.compact;
  bool get isExpanded => windowSize == WindowSize.expanded;

  /// Horizontal page padding that grows with the window.
  double get pagePadding => switch (windowSize) {
    WindowSize.compact => 16,
    WindowSize.medium => 24,
    WindowSize.expanded => 32,
  };
}

/// Centers [child] and caps its width on large screens.
class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.maxContentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  // heightFactor: 1 keeps the box as tall as its child, so it can be used in
  // slots with loose height constraints (e.g. Scaffold.bottomNavigationBar).
  Widget build(BuildContext context) => Center(
    heightFactor: 1,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}
