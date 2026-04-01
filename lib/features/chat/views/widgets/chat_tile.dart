import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttr/features/chat/models/message_model.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:fluttr/theme/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/shared/utils/page_transaction.dart';
import 'package:fluttr/features/chat/views/chat.dart';
import 'package:fluttr/features/profile/views/profile.dart';
import 'package:fluttr/shared/widgets/avatar.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.user,
    required this.lastMessage,
    this.lastMessageType,
    required this.lastMessageSenderId,
    required this.time,
    this.unreadCount = 0,
  });

  final UserModel user;
  final String? lastMessage;
  final MessageType? lastMessageType;
  final String? lastMessageSenderId;
  final DateTime? time;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final isUnread = unreadCount > 0;
    final isOnline = Random().nextInt(10) > 5;
    final contentColor = isUnread ? Colors.white : Colors.grey;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: .stretch,
        children: [
          GestureDetector(
            behavior: .opaque,
            onTap: () {
              Navigator.push(
                context,
                slideToTopPageTransition(ProfilePage(uid: user.uid)),
              );
            },
            child: Padding(
              padding: .symmetric(horizontal: 16, vertical: 10),
              child: Avatar(url: user.photoUrl, size: 72),
            ),
          ),

          Expanded(
            flex: 1,
            child: GestureDetector(
              behavior: .opaque,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatPage(otherUserId: user.uid),
                  ),
                );
              },

              child: Container(
                padding: const .symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .center,
                      spacing: 2,
                      children: [
                        Row(
                          crossAxisAlignment: .center,
                          spacing: 4,
                          children: [
                            if (isOnline)
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: AppColors.success,
                              ),
                            Text(
                              user.displayName ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: contentColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 4,
                          children: [
                            if (lastMessageSenderId == currentUser.value!.uid)
                              Icon(Icons.reply, size: 14, color: contentColor),
                            if (lastMessageType == MessageType.image) ...[
                              Icon(
                                Icons.camera_alt,
                                size: 14,
                                color: contentColor,
                              ),
                              Text(
                                'Photo ${lastMessageSenderId == currentUser.value!.uid ? 'sent' : 'received'}',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 16,
                                  fontWeight: isUnread ? .bold : .normal,
                                  color: contentColor,
                                ),
                              ),
                            ],
                            if (lastMessageType == MessageType.text)
                              Text(
                                lastMessage ?? '',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 16,
                                  fontWeight: isUnread ? .bold : .normal,
                                  color: contentColor,
                                ),
                                maxLines: 1,
                                overflow: .ellipsis,
                              ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      padding: .only(left: 8, right: 16),
                      child: Column(
                        crossAxisAlignment: .end,
                        mainAxisAlignment: .center,
                        spacing: 8,
                        children: [
                          Text(
                            '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          isUnread
                              ? Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: .center,
                                  child: Text(
                                    '$unreadCount',
                                    style: GoogleFonts.ibmPlexSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                )
                              : SizedBox(width: 24, height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
