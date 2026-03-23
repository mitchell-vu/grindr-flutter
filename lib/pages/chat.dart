import 'package:flutter/material.dart';
import 'package:grindr_flutter/widgets/chat_tile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 24,
      itemBuilder: (context, index) {
        final isUnread = index > 0 && index % 3 == 0;

        return ChatListItem(
          avatarUrl:
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
          name: 'Mitchell',
          lastMessage: 'Hi! u looking? 👀',
          time: '12:00',
          unreadCount: isUnread ? index : 0,
        );
      },
    );
  }
}
