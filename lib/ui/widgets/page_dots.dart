import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Page indicator: the active page is a wide pill, others are small squares.
class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 0; i < count; i++)
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: i == index ? 22 : 8,
          height: 6,
          decoration: BoxDecoration(
            color: i == index ? AppColors.primary : AppColors.textMuted,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
    ],
  );
}
