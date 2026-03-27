import 'package:flutter/material.dart';
import 'package:grindr_flutter/configs/theme.dart';
import 'package:grindr_flutter/features/chat/views/widgets/message_bubble.dart';
import 'package:grindr_flutter/shared/utils/page_transaction.dart';
import 'package:grindr_flutter/features/profile/profile.dart';

class ChatMessage {
  final String message;
  final bool isMe;

  ChatMessage({required this.message, required this.isMe});
}

final List<ChatMessage> _mockChatHistory = [
  ChatMessage(message: 'Hi! u looking? 👀', isMe: false),
  ChatMessage(message: 'Yeah', isMe: true),
  ChatMessage(message: 'Where are you?', isMe: false),
  ChatMessage(message: 'I am at home', isMe: true),
  ChatMessage(message: 'Can you host?', isMe: false),
  ChatMessage(message: 'Yeah, i can!', isMe: true),
  ChatMessage(message: 'Ok, I will come to you', isMe: false),
  ChatMessage(message: 'Ok, I will wait for you', isMe: true),
  ChatMessage(message: 'Ok, I will see you soon', isMe: false),
  ChatMessage(message: 'Ok, I will see you soon', isMe: true),
  ChatMessage(message: 'Yeah, i can!', isMe: true),
  ChatMessage(message: 'Ok, I will come to you', isMe: false),
  ChatMessage(message: 'Ok, I will wait for you', isMe: true),
  ChatMessage(message: 'Ok, I will see you soon', isMe: false),
  ChatMessage(message: 'Ok, I will see you soon', isMe: true),
];

class ChatHistoryPage extends StatelessWidget {
  const ChatHistoryPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                    spacing: 6,
                    children: [
                      Icon(Icons.circle, size: 12, color: AppTheme.success),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
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
                child: ListView.builder(
                  itemCount: _mockChatHistory.length,
                  itemBuilder: (context, index) {
                    final chatMessage = _mockChatHistory[index];

                    return MessageBubble(
                      content: chatMessage.message,
                      isMe: chatMessage.isMe,
                    );
                  },
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
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Say something...',
                                border: InputBorder.none,
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            color: AppTheme.primary,
                            onPressed: () {},
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
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.gif_box)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.navigation_sharp),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.emoji_emotions),
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
