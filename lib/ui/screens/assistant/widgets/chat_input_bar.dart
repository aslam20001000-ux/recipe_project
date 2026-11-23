import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../l10n/l10n_labels.dart';

/// Text field with a send button that turns into stop while replying.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.replying,
    required this.onSend,
    required this.onStop,
  });

  final TextEditingController controller;
  final bool replying;
  final ValueChanged<String> onSend;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final padding = context.pagePadding;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, 8, padding, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.send,
                onSubmitted: replying ? null : onSend,
                decoration: InputDecoration(
                  hintText: context.l10n.assistantHint,
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              tooltip: replying ? context.l10n.stop : context.l10n.send,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                minimumSize: const Size(48, 48),
              ),
              onPressed: replying ? onStop : () => onSend(controller.text),
              // Mirrors in RTL so the arrow points the reading direction.
              icon: Icon(replying ? Icons.stop_rounded : Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
