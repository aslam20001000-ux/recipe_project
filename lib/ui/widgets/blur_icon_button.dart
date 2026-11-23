import 'dart:ui';

import 'package:flutter/material.dart';

/// Circular button with a frosted-glass (background blur) effect, used on
/// top of images.
class BlurIconButton extends StatelessWidget {
  const BlurIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.tooltip,
  });

  /// Usually an [Icon]; can also be another button such as FavoriteButton.
  final Widget child;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) => ClipOval(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Material(
        color: Colors.black.withValues(alpha: 0.3),
        child: onPressed == null
            ? SizedBox.square(dimension: 44, child: Center(child: child))
            : IconButton(
                tooltip: tooltip,
                onPressed: onPressed,
                icon: child,
                color: Colors.white,
              ),
      ),
    ),
  );
}
