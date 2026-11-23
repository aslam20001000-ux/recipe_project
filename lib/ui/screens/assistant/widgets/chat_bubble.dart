import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/chat_message.dart';
import '../../../../l10n/l10n_labels.dart';

/// One message. User messages sit at the end side, assistant at the start.
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    this.pending = false,
    this.searching = false,
    this.errorText,
  });

  final ChatMessage message;

  /// The reply was requested but no text has arrived yet.
  final bool pending;

  /// The reply is waiting on a web search.
  final bool searching;

  /// Shown instead of the text when the reply failed.
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final isError = errorText != null;
    const radius = Radius.circular(18);

    final status = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        searching
            ? const Icon(
                Icons.travel_explore,
                size: 16,
                color: AppColors.primary,
              )
            : const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            searching
                ? context.l10n.assistantSearching
                : context.l10n.assistantThinking,
            style: AppText.caption,
          ),
        ),
      ],
    );

    final Widget child;
    if (pending) {
      child = status;
    } else if (isError) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: AppColors.danger, size: 18),
          const SizedBox(width: 8),
          Flexible(child: Text(errorText!, style: AppText.body)),
        ],
      );
    } else {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(
            message.text.trim(),
            style: AppText.body.copyWith(
              color: isUser ? AppColors.onPrimary : AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          // Searching again after some text already arrived.
          if (searching) ...[const SizedBox(height: 8), status],
          if (message.sources.isNotEmpty) _Sources(message.sources),
        ],
      );
    }

    return Align(
      alignment: isUser
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) ...[
              const CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.surfaceHigh,
                child: Icon(
                  Icons.auto_awesome,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isUser
                      ? AppColors.primary
                      : isError
                      ? AppColors.danger.withValues(alpha: 0.12)
                      : AppColors.surface,
                  border: isUser
                      ? null
                      : Border.all(
                          color: isError
                              ? AppColors.danger.withValues(alpha: 0.4)
                              : AppColors.border,
                        ),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: radius,
                    topEnd: radius,
                    bottomStart: isUser ? radius : const Radius.circular(4),
                    bottomEnd: isUser ? const Radius.circular(4) : radius,
                  ),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Web pages the answer was based on, under a thin divider.
class _Sources extends StatelessWidget {
  const _Sources(this.sources);

  final List<WebSource> sources;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.public, size: 14, color: AppColors.textMuted),
                const SizedBox(width: 6),
                Text(context.l10n.sources, style: AppText.caption),
              ],
            ),
            for (final s in sources)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: SelectableText(
                  '• ${s.title} · ${s.site}',
                  style: AppText.caption.copyWith(color: AppColors.accentTeal),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
