import 'package:flutter/material.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/features/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttr/models/user_model.dart';
import 'package:fluttr/features/chat/views/widgets/chat_tile.dart';
import 'package:fluttr/shared/data.dart';
import 'package:fluttr/shared/widgets/avatar.dart';

class ChatListPage extends GetView<ChatController> {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
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
                  'Inbox',
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
            onRefresh: () async => await controller.refreshChatList(),
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
                Obx(
                  () => Column(
                    children:
                        controller.chatWithUserList.value?.map((chatWithUser) {
                          return ChatListItem(
                            user: chatWithUser.user,
                            lastMessage: chatWithUser.chat.lastMessage,
                            lastMessageType: chatWithUser.chat.lastMessageType,
                            lastMessageSenderId:
                                chatWithUser.chat.lastMessageSenderId,
                            time: chatWithUser.chat.lastMessageTime,
                            // unreadCount: isUnread ? index : 0,
                          );
                        }).toList() ??
                        [],
                  ),
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
            'Unread',
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: true,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text(
            'Online',
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: false,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text(
            'Distance',
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
    final AuthController authController = Get.put(AuthController());
    return Column(
      spacing: 4,
      children: [
        Stack(
          children: [
            Avatar(
              url: authController.userModel!.photoUrl,
              size: 64,
              rounded: true,
            ),
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
          'Stories',
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
          user.displayName ?? '',
          style: TextStyle(color: Colors.white, fontSize: 14),
          maxLines: 1,
          overflow: .ellipsis,
        ),
      ],
    );
  }
}
