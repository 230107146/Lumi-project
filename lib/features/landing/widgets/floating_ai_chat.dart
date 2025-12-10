import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class FloatingAiChat extends StatefulWidget {
  const FloatingAiChat({super.key});

  @override
  State<FloatingAiChat> createState() => _FloatingAiChatState();
}

class _FloatingAiChatState extends State<FloatingAiChat>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! I am your AI coach. How can I help?', 'user': false}
  ];
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isOpen = !_isOpen);
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'text': text, 'user': true});
      // simple echo reply for demo
      _messages.add({'text': 'Got it: "$text"', 'user': false});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Outer container animates between compact (60x60) and expanded sizes.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: _isOpen ? 350 : 60,
      height: _isOpen ? 560 : 60,
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          // Chat panel
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            bottom: _isOpen ? 80 : 20,
            right: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isOpen ? 1.0 : 0.0,
              child: IgnorePointer(
                ignoring: !_isOpen,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 350,
                  height: _isOpen ? 500 : 0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(46),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          color: AppColors.primary,
                          child: Row(
                            children: [
                              const Icon(Icons.smart_toy, color: Colors.white),
                              const SizedBox(width: 8),
                              const Expanded(
                                  child: Text('AI Coach',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              IconButton(
                                onPressed: _toggle,
                                icon: const Icon(Icons.close,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),

                        // Messages
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(12),
                            child: ListView.builder(
                              reverse: true,
                              itemCount: _messages.length,
                              itemBuilder: (context, index) {
                                final msg =
                                    _messages[_messages.length - 1 - index];
                                final isUser = msg['user'] as bool;
                                return Align(
                                  alignment: isUser
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    constraints:
                                        const BoxConstraints(maxWidth: 240),
                                    decoration: BoxDecoration(
                                      color: isUser
                                          ? AppColors.primary.withAlpha(31)
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(msg['text'] as String),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Input
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: 'Type a message',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  onSubmitted: (_) => _send(),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 44,
                                height: 44,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  onPressed: _send,
                                  child: const Icon(Icons.send, size: 20),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Floating button
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _toggle,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(56),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Icon(
                  _isOpen ? Icons.close : Icons.chat_bubble_outline,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
