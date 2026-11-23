import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/l10n_labels.dart';
import '../../state/locale_controller.dart';

/// Globe button that switches the app language (English / العربية).
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  // Each language is shown in its own script, whatever the current locale.
  static const _names = {'en': 'English', 'ar': 'العربية'};

  @override
  Widget build(BuildContext context) {
    final current = Localizations.localeOf(context).languageCode;
    return PopupMenuButton<Locale>(
      tooltip: context.l10n.language,
      position: PopupMenuPosition.under,
      onSelected: context.read<LocaleController>().setLocale,
      itemBuilder: (_) => [
        for (final locale in LocaleController.supported)
          PopupMenuItem(
            value: locale,
            child: Row(
              children: [
                Expanded(child: Text(_names[locale.languageCode]!)),
                if (locale.languageCode == current)
                  const Icon(Icons.check, size: 18, color: AppColors.primary),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.translate,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              current == 'ar' ? 'EN' : 'ع',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
