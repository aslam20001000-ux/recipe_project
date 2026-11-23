import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Title + subtitle used at the top of the main tabs.
class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppText.display.copyWith(fontSize: 26)),
      const SizedBox(height: 4),
      Text(subtitle, style: AppText.caption),
    ],
  );
}
