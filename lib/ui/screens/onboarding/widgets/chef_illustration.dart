import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// The chef illustration on a soft blob background.
///
/// Drop the exported Figma illustration at `assets/images/chef.png` to use it;
/// until then a styled icon is shown.
class ChefIllustration extends StatelessWidget {
  const ChefIllustration({super.key, this.size = 260});

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: -0.35,
          child: Container(
            width: size * 0.78,
            height: size * 0.92,
            decoration: BoxDecoration(
              color: AppColors.blob,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size * 0.5),
                topRight: Radius.circular(size * 0.35),
                bottomLeft: Radius.circular(size * 0.3),
                bottomRight: Radius.circular(size * 0.5),
              ),
            ),
          ),
        ),
        Image.asset(
          'assets/images/chef.png',
          height: size * 0.95,
          errorBuilder: (context, error, stack) => Icon(
            Icons.soup_kitchen_outlined,
            size: size * 0.45,
            color: AppColors.primary,
          ),
        ),
      ],
    ),
  );
}
