import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/recipe.dart';
import '../../../l10n/l10n_labels.dart';
import '../../../services/chef_assistant.dart';
import '../../../state/chat_controller.dart';
import '../../../state/user_controller.dart';
import '../../widgets/page_header.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/suggestion_chips.dart';

/// Chat with the AI cooking assistant.
///
/// Used as a main tab (general questions) and pushed from a recipe's details
/// page with [recipe] set, so "this dish" refers to that recipe.
class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key, this.recipe});

  final Recipe? recipe;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    // Ephemeral: each chat screen owns its own conversation.
    create: (context) => ChatController(context.read<ChefAssistant>()),
    child: _AssistantView(recipe: recipe),
  );
}

class _AssistantView extends StatefulWidget {
  const _AssistantView({this.recipe});

  final Recipe? recipe;

  @override
  State<_AssistantView> createState() => _AssistantViewState();
}

class _AssistantViewState extends State<_AssistantView> {
  final _input = TextEditingController();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send(String text) {
    final user = context.read<UserController>();
    context.read<ChatController>().send(
      text,
      AssistantContext(
        userName: user.name,
        level: user.level,
        languageCode: Localizations.localeOf(context).languageCode,
        recipe: widget.recipe,
      ),
    );
    _input.clear();
  }

  /// Keeps the newest text in view while a reply streams in.
  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  String _errorText(AssistantException? e) {
    final l = context.l10n;
    return switch (e?.kind) {
      AssistantErrorKind.notConfigured => l.assistantNotConfigured,
      AssistantErrorKind.refusal => l.assistantErrorRefusal,
      AssistantErrorKind.api => l.assistantErrorApi(e?.detail ?? ''),
      _ => l.assistantErrorNetwork,
    };
  }

  List<String> _suggestions() {
    final l = context.l10n;
    final r = widget.recipe;
    if (r == null) {
      return [l.suggestGeneral1, l.suggestGeneral2, l.suggestGeneral3];
    }
    final dish = context.tr(r.name);
    return [l.suggestDish1(dish), l.suggestDish2(dish), l.suggestDish3(dish)];
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatController>();
    final messages = chat.messages;
    final padding = context.pagePadding;
    final pushed = widget.recipe != null;
    if (chat.isReplying) _scrollToEnd();

    final header = Padding(
      padding: EdgeInsetsDirectional.fromSTEB(pushed ? 4 : padding, 12, 8, 8),
      child: Row(
        children: [
          if (pushed)
            IconButton(
              tooltip: context.l10n.back,
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          Expanded(
            child: PageHeader(
              title: context.l10n.assistant,
              subtitle: pushed
                  ? context.tr(widget.recipe!.name)
                  : context.l10n.assistantSubtitle,
            ),
          ),
          if (messages.isNotEmpty)
            IconButton(
              tooltip: context.l10n.newChat,
              onPressed: chat.clear,
              icon: const Icon(Icons.add_comment_outlined),
            ),
        ],
      ),
    );

    final body = messages.isEmpty
        ? _EmptyChat(
            configured: chat.isConfigured,
            suggestions: _suggestions(),
            onSuggestion: _send,
          )
        : ListView.separated(
            controller: _scroll,
            padding: EdgeInsets.fromLTRB(padding, 8, padding, 16),
            itemCount: messages.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final m = messages[i];
              final isLast = i == messages.length - 1;
              return ChatBubble(
                message: m,
                pending: isLast && chat.isReplying && m.text.isEmpty,
                searching: isLast && chat.isSearching,
                errorText: m.isError ? _errorText(chat.lastError) : null,
              );
            },
          );

    final content = SafeArea(
      bottom: false,
      child: MaxWidthBox(
        maxWidth: 820,
        child: Column(
          children: [
            header,
            Expanded(child: body),
            ChatInputBar(
              controller: _input,
              replying: chat.isReplying,
              onSend: _send,
              onStop: chat.stop,
            ),
          ],
        ),
      ),
    );

    return pushed ? Scaffold(body: content) : content;
  }
}

class _EmptyChat extends StatelessWidget {
  const _EmptyChat({
    required this.configured,
    required this.suggestions,
    required this.onSuggestion,
  });

  final bool configured;
  final List<String> suggestions;
  final ValueChanged<String> onSuggestion;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(context.pagePadding),
    child: Column(
      children: [
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: AppColors.primary,
            size: 36,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          context.l10n.assistantEmptyTitle,
          style: AppText.heading,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.assistantEmptyBody,
          style: AppText.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        if (!configured)
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.key, color: AppColors.warning, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    context.l10n.assistantNotConfigured,
                    style: AppText.caption.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        SuggestionChips(suggestions: suggestions, onSelected: onSuggestion),
      ],
    ),
  );
}
