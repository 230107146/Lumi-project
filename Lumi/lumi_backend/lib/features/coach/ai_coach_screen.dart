import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/responsive_wrapper.dart';

// Simple chat message model
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  ChatMessage({required this.text, required this.isUser, DateTime? time})
      : time = time ?? DateTime.now();
}

class AICoachScreen extends StatefulWidget {
  const AICoachScreen({super.key});

  @override
  State<AICoachScreen> createState() => _AICoachScreenState();
}

class _AICoachScreenState extends State<AICoachScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
        text: 'Hello! I am LUMI. How are you feeling today?', isUser: false),
  ];

  bool _isTyping = false;

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    _ctrl.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isTyping = true;
    });
    _scrollToEndDelayed();

    Future.delayed(const Duration(seconds: 1), () {
      final lower = text.toLowerCase();
      String reply;
      if (lower.contains('sad')) {
        reply = 'I hear you. Remember why you started.';
      } else if (lower.contains('drink')) {
        reply = 'Try to drink a glass of water instead. You can do this!';
      } else {
        reply = "Tell me more about that. I'm here for you.";
      }

      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(text: reply, isUser: false));
      });
      _scrollToEndDelayed();
    });
  }

  void _scrollToEndDelayed() {
    Future.delayed(const Duration(milliseconds: 250), () {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveUtil.isDesktop(context);
    final padding = ResponsiveUtil.getPadding(context);
    final titleSize = ResponsiveUtil.getHeadline3FontSize(context);
    final bodySize = ResponsiveUtil.getBodyFontSize(context);
    final maxChatWidth = isDesktop ? 800.0 : 600.0;
    final inputPadding =
        EdgeInsets.symmetric(horizontal: padding * 0.5, vertical: 12);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.smart_toy)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LUMI Coach',
                    style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: titleSize, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text('Always here to listen',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontSize: bodySize - 4, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: ResponsiveWrapper(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxChatWidth),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: theme.colorScheme.surface,
                  child: ListView.builder(
                    controller: _scroll,
                    padding: EdgeInsets.symmetric(
                        horizontal: padding * 0.4, vertical: 16),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _messages.length) {
                        // typing indicator
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text('LUMI is typing...',
                                style: TextStyle(fontSize: bodySize - 2)),
                          ),
                        );
                      }

                      final msg = _messages[index];
                      final align = msg.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft;
                      final bg =
                          msg.isUser ? AppColors.primary : AppColors.surface;
                      final txtColor =
                          msg.isUser ? Colors.white : Colors.black87;
                      final radius = msg.isUser
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))
                          : const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12));

                      return Align(
                        alignment: align,
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: maxChatWidth * 0.75),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration:
                              BoxDecoration(color: bg, borderRadius: radius),
                          child: Text(msg.text,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: bodySize, color: txtColor)),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // input area
              Container(
                padding: inputPadding,
                decoration: BoxDecoration(color: AppColors.surface, boxShadow: [
                  BoxShadow(
                      color: const Color(0x10000000),
                      blurRadius: 6,
                      offset: const Offset(0, -2))
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(fontSize: bodySize)),
                        onSubmitted: (_) => _send(),
                        style: TextStyle(fontSize: bodySize),
                      ),
                    ),
                    IconButton(
                      onPressed: _send,
                      icon: const Icon(Icons.send),
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
