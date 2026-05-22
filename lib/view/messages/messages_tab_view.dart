import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../view_model/messages/messages_view_model.dart';

class MessagesTabView extends StatelessWidget {
  const MessagesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<MessagesViewModel>();
    final threads =
        vm.sellingTabIndex == 0 ? vm.sellingThreads : vm.buyingThreads;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Text(
            l10n.messagesTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Text(
            l10n.messagesScreenSubtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _TabHeader(
                        label: l10n.tabSelling,
                        selected: vm.sellingTabIndex == 0,
                        onTap: () => vm.setTab(0),
                      ),
                    ),
                    Expanded(
                      child: _TabHeader(
                        label: l10n.tabBuying,
                        selected: vm.sellingTabIndex == 1,
                        onTap: () => vm.setTab(1),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 1),
                ...threads.map((t) => _ThreadRow(thread: t)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                    child: Text(
                      l10n.chatHeaderDeal,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Text(
                      l10n.chatParticipantSample,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: vm.activeChat.length,
                      itemBuilder: (context, i) {
                        final m = vm.activeChat[i];
                        return Align(
                          alignment: m.isMine
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            constraints: const BoxConstraints(maxWidth: 280),
                            decoration: BoxDecoration(
                              color: m.isMine
                                  ? AppColors.chatOutgoing
                                  : AppColors.chatIncoming,
                              borderRadius: BorderRadius.circular(16),
                              border: m.isMine
                                  ? null
                                  : Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              m.text,
                              style: TextStyle(
                                color:
                                    m.isMine ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: vm.composer,
                            decoration: InputDecoration(
                              hintText: l10n.chatInputHint,
                              filled: true,
                              fillColor: AppColors.inputFill,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.primary,
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: () => vm.sendMessage(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TabHeader extends StatelessWidget {
  const _TabHeader({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: selected ? 48 : 0,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThreadRow extends StatelessWidget {
  const _ThreadRow({required this.thread});

  final MessageThreadUi thread;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            thread.dealTitle,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          subtitle: Text(thread.snippet),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                thread.time,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              if (thread.unread > 0)
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${thread.unread}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
