import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/features/chat/models/chat_model.dart';
import 'package:fluttr/features/chat/services/chat_service.dart';
import 'package:fluttr/features/chat/views/widgets/chat_tile.dart';
import 'package:fluttr/shared/data.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:fluttr/shared/widgets/avatar.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late Future<List<({ChatModel chat, UserModel user})>> _chatsFuture;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  void _loadChats() {
    _chatsFuture = ChatService().getChatListWithUsers(currentUser.value!.uid);
  }

  Future<void> _refresh() async {
    setState(() {
      _loadChats();
    });
    try {
      await _chatsFuture;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const .only(left: 16, right: 16, top: 8, bottom: 16),
            child: Column(
              crossAxisAlignment: .stretch,
              spacing: 4,
              children: [
                Text(
                  "Inbox",
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 24,
                    fontWeight: .bold,
                    color: Colors.white,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: ChatsFilter(),
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: .zero,
              children: [
                // Horizontal stories row
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Padding(
                    padding: const .symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      spacing: 24,
                      children: [
                        MyStories(),
                        ...List.generate(4, (index) {
                          return UserStories(user: mockUser);
                        }),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 8),

                // Chat list
                FutureBuilder<List<({ChatModel chat, UserModel user})>>(
                  future: _chatsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.map((item) {
                          final chat = item.chat;
                          final user = item.user;

                          return ChatListItem(
                            user: user,
                            lastMessage: chat.lastMessage,
                            lastMessageSenderId: chat.lastMessageSenderId,
                            time: chat.lastMessageTime,
                            // unreadCount: isUnread ? index : 0,
                          );
                        }).toList(),
                      );
                    }

                    return Center(
                      child: Text(
                        "Error",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChatsFilter extends StatelessWidget {
  const ChatsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        ChoiceChip(
          label: Text(
            "Unread",
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: true,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text(
            "Online",
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: false,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text(
            "Distance",
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: false,
          onSelected: (value) {},
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
            Avatar(url: currentUser.value!.photoUrl, size: 64, rounded: true),
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                padding: .all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: .circular(100),
                  border: .all(color: Colors.black, width: 4),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                  fontWeight: .bold,
                ),
              ),
            ),
          ],
        ),
        Text(
          "Stories",
          style: TextStyle(color: Colors.grey, fontSize: 14),
          maxLines: 1,
          overflow: .ellipsis,
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
        Avatar(url: user.photoUrl, size: 64, rounded: true),
        Text(
          user.displayName ?? "",
          style: TextStyle(color: Colors.white, fontSize: 14),
          maxLines: 1,
          overflow: .ellipsis,
        ),
      ],
    );
  }
}
