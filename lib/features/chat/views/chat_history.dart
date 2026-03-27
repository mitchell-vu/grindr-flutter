import 'package:flutter/material.dart';
import 'package:grindr_flutter/configs/theme.dart';
import 'package:grindr_flutter/features/chat/views/widgets/message_bubble.dart';
import 'package:grindr_flutter/shared/utils/page_transaction.dart';
import 'package:grindr_flutter/features/profile/profile.dart';

class ChatMessage {
  final String message;
  final bool isMe;
  final DateTime createdAt;

  ChatMessage({
    required this.message,
    required this.isMe,
    required this.createdAt,
  });
}

final List<ChatMessage> _mockChatHistory = [
  ChatMessage(
    message: 'Hi! How you doing?',
    isMe: false,
    createdAt: DateTime.now(),
  ),
  ChatMessage(message: 'I am fine', isMe: true, createdAt: DateTime.now()),
  ChatMessage(message: 'Hbu?', isMe: true, createdAt: DateTime.now()),
  ChatMessage(message: 'I am cool too', isMe: false, createdAt: DateTime.now()),
  ChatMessage(
    message: 'So you looking? 👀',
    isMe: false,
    createdAt: DateTime.now(),
  ),
  ChatMessage(
    message: 'Where are you?',
    isMe: false,
    createdAt: DateTime.now(),
  ),
  ChatMessage(message: 'I am at home', isMe: true, createdAt: DateTime.now()),
  ChatMessage(message: 'Can you host?', isMe: false, createdAt: DateTime.now()),
  ChatMessage(message: 'Yeah, i can!', isMe: true, createdAt: DateTime.now()),
  ChatMessage(
    message: 'Ok, I will come to you',
    isMe: false,
    createdAt: DateTime.now(),
  ),
];

ValueNotifier<List<ChatMessage>> chatHistory = ValueNotifier(_mockChatHistory);

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({super.key, required this.title});

  final String title;

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollToBottom();
  }

  @override
  void dispose() async {
    _scrollController.dispose();
    super.dispose();
  }

  void handleSendMessage() {
    final message = _messageController.text;

    if (message.isNotEmpty) {
      chatHistory.value = [
        ...chatHistory.value,
        ChatMessage(message: message, isMe: true, createdAt: DateTime.now()),
      ];
      _messageController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    //? TODO: Tìm hiểu SchedulerBinding với WidgetsBinding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(context, slideToTopPageTransaction(ProfilePage()));
          },
          child: Row(
            spacing: 12,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  'https://static.wikia.nocookie.net/marias/images/9/95/CINEMA.jpg/revision/latest/scale-to-width-down/1200?cb=20250708183259',
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.circle, size: 12, color: AppTheme.success),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text('2km away', style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_rounded)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: chatHistory,
                  builder: (context, chatHistory, child) => ListView.builder(
                    controller: _scrollController,
                    itemCount: chatHistory.length,
                    itemBuilder: (context, index) {
                      final chatMessage = chatHistory[index];
                      final isNextMessageSameUser =
                          index < chatHistory.length - 1 &&
                          chatHistory[index + 1].isMe == chatMessage.isMe;

                      return MessageBubble(
                        message: chatMessage,
                        showTimestamp: !isNextMessageSameUser,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 16.0,
                  bottom: 8.0,
                ),
                child: Column(
                  spacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 4,
                        top: 4,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Say something...',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            color: AppTheme.primary,
                            onPressed: handleSendMessage,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.photo_camera),
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.gif_box),
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.navigation_sharp),
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.emoji_emotions),
                          color: Colors.grey,
                        ),
                      ],
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
