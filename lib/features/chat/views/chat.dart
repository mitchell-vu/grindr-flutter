import 'package:flutter/material.dart';
import 'package:grindr_flutter/features/chat/views/widgets/chat_tile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Horizontal stories row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              spacing: 24,
              children: List.generate(8, (index) {
                return Column(
                  spacing: 4,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        'https://static.wikia.nocookie.net/marias/images/9/95/CINEMA.jpg/revision/latest/scale-to-width-down/1200?cb=20250708183259',
                      ),
                    ),
                    Text(
                      "Mariás",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),

        // Chat list
        ...List.generate(24, (index) {
          final isUnread = index > 0 && index % 3 == 0;

          return Dismissible(
            key: ValueKey(index),
            direction: DismissDirection.endToStart,
            child: ChatListItem(
              avatarUrl:
                  'https://static.wikia.nocookie.net/marias/images/9/95/CINEMA.jpg/revision/latest/scale-to-width-down/1200?cb=20250708183259',
              name: 'Mitchell',
              lastMessage: 'Hi! u looking? 👀',
              time: '12:00',
              unreadCount: isUnread ? index : 0,
            ),
          );
        }),
      ],
    );
  }
}
