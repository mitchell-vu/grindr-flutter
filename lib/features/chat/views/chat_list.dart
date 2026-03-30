import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grindr_flutter/configs/constants.dart';
import 'package:grindr_flutter/features/auth/models/user_model.dart';
import 'package:grindr_flutter/features/chat/services/chat_service.dart';
import 'package:grindr_flutter/features/chat/views/widgets/chat_tile.dart';
import 'package:grindr_flutter/shared/data.dart';
import 'package:grindr_flutter/shared/services/auth_service.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 16,
            ),
            child: Row(
              children: [
                Text(
                  "Inbox",
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Horizontal stories row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    spacing: 24,
                    children: [
                      MyStories(),
                      ...List.generate(8, (index) {
                        return UserStories(user: mockUser);
                      }),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8),

              // Chat list
              FutureBuilder(
                future: ChatService().getChatListWithUsers(
                  currentUser.value!.uid,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!.map((item) {
                        final chat = item.chat;
                        final user = item.user;

                        return ChatListItem(
                          userId: user.uid,
                          avatarUrl:
                              user.photoUrl ??
                              'https://static.wikia.nocookie.net/marias/images/9/95/CINEMA.jpg/revision/latest/scale-to-width-down/1200?cb=20250708183259',
                          name: user.displayName ?? 'Unknown',
                          lastMessage: chat.lastMessage ?? 'No messages yet',
                          time:
                              '${chat.lastMessageTime?.hour.toString().padLeft(2, '0')}:${chat.lastMessageTime?.minute.toString().padLeft(2, '0')}',
                          // unreadCount: isUnread ? index : 0,
                        );
                      }).toList(),
                    );
                  }

                  return Center(
                    child: Text("Error", style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyStories extends StatelessWidget {
  const MyStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(
                currentUser.value!.photoUrl ?? avatarPlaceholderUrl,
              ),
            ),
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black, width: 4),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Text(
          "Stories",
          style: TextStyle(color: Colors.grey, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class UserStories extends StatelessWidget {
  const UserStories({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(user.photoUrl ?? avatarPlaceholderUrl),
        ),
        Text(
          user.displayName ?? "",
          style: TextStyle(color: Colors.white, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
