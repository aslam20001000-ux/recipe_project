import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Feature highlight. Horizontal row on phones, vertical card on tablets.
class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.vertical = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final iconBox = Container(
      width: vertical ? 56 : 36,
      height: vertical ? 56 : 36,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.primary, size: vertical ? 30 : 20),
    );

    final texts = [
      Text(
        title,
        style: AppText.title.copyWith(fontSize: 14),
        textAlign: vertical ? TextAlign.center : TextAlign.start,
      ),
      const SizedBox(height: 4),
      Text(
        subtitle,
        style: AppText.caption,
        textAlign: vertical ? TextAlign.center : TextAlign.start,
      ),
    ];

    return Container(
      padding: EdgeInsets.all(vertical ? 20 : 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: vertical
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [iconBox, const SizedBox(height: 16), ...texts],
            )
          : Row(
              children: [
                iconBox,
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: texts,
                  ),
                ),
              ],
            ),
    );
  }
}
