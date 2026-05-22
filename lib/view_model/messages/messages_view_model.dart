import 'package:flutter/material.dart';

class MessageThreadUi {
  const MessageThreadUi({
    required this.dealTitle,
    required this.snippet,
    required this.time,
    this.unread = 0,
  });

  final String dealTitle;
  final String snippet;
  final String time;
  final int unread;
}

class ChatBubbleUi {
  const ChatBubbleUi({required this.text, required this.isMine});

  final String text;
  final bool isMine;
}

class MessagesViewModel extends ChangeNotifier {
  int sellingTabIndex = 0; // 0 selling, 1 buying

  final List<MessageThreadUi> sellingThreads = const [
    MessageThreadUi(
      dealTitle: 'Deal #4587',
      snippet: 'Quality samples received, looks good',
      time: '12:03 AM',
      unread: 2,
    ),
    MessageThreadUi(
      dealTitle: 'Deal #4572',
      snippet: 'Please confirm shipment date',
      time: 'Yesterday',
    ),
  ];

  final List<MessageThreadUi> buyingThreads = const [
    MessageThreadUi(
      dealTitle: 'Deal #4563',
      snippet: 'Counter offer sent',
      time: 'Mon',
      unread: 1,
    ),
  ];

  final List<ChatBubbleUi> activeChat = [
    const ChatBubbleUi(
      text: 'Salam, when can you ship the order?',
      isMine: false,
    ),
    const ChatBubbleUi(
      text: 'Please confirm shipment date',
      isMine: false,
    ),
    const ChatBubbleUi(
      text: 'Wa-salam, by Friday inshaAllah.',
      isMine: true,
    ),
  ];

  final TextEditingController composer = TextEditingController();

  void setTab(int i) {
    if (sellingTabIndex == i) return;
    sellingTabIndex = i;
    notifyListeners();
  }

  void sendMessage() {
    final t = composer.text.trim();
    if (t.isEmpty) return;
    activeChat.add(ChatBubbleUi(text: t, isMine: true));
    composer.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    composer.dispose();
    super.dispose();
  }
}
