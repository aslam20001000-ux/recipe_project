import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/l10n_labels.dart';
import '../../../../state/user_controller.dart';
import '../../../widgets/highlighted_title.dart';
import '../../../widgets/language_button.dart';
import 'level_dropdown.dart';

/// "Good Morning, Ahmed!" + level dropdown. Refreshes every minute so the
/// greeting follows the time of day.
class GreetingHeader extends StatefulWidget {
  const GreetingHeader({super.key});

  @override
  State<GreetingHeader> createState() => _GreetingHeaderState();
}

class _GreetingHeaderState extends State<GreetingHeader> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = context.select((UserController u) => u.name);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighlightedTitle(
                text:
                    '${greetingFor(DateTime.now(), context.l10n)}${context.l10n.nameSeparator}',
                highlight: name,
                suffix: '!',
                style: AppText.heading,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 4),
              Text(context.l10n.readyToCook, style: AppText.caption),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Stacked so the greeting keeps enough width on narrow phones.
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 8,
          children: [LevelDropdown(), LanguageButton()],
        ),
      ],
    );
  }
}
