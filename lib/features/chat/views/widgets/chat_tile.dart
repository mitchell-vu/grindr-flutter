import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttr/configs/theme.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/shared/utils/page_transaction.dart';
import 'package:fluttr/features/chat/views/chat.dart';
import 'package:fluttr/features/profile/profile.dart';
import 'package:fluttr/shared/widgets/avatar.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.user,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });

  final UserModel user;
  final String? lastMessage;
  final DateTime? time;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final isUnread = unreadCount > 0;
    final isOnline = Random().nextInt(10) > 5;
    final contentColor = isUnread ? Colors.white : Colors.grey;

    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
              context,
              slideToTopPageTransaction(ProfilePage(uid: user.uid)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Avatar(url: user.photoUrl, size: 72),
          ),
        ),

        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatPage(otherUserId: user.uid),
                ),
              );
            },

            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 4,
                        children: [
                          if (isOnline)
                            Icon(
                              Icons.circle,
                              size: 12,
                              color: AppTheme.success,
                            ),
                          Text(
                            user.displayName ?? '',
                            style: TextStyle(fontSize: 16, color: contentColor),
                          ),
                        ],
                      ),
                      Text(
                        lastMessage ?? '',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 16,
                          fontWeight: isUnread
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: contentColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Time + unread badge
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 8,
                    children: [
                      Text(
                        '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      if (isUnread)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$unreadCount',
                            style: GoogleFonts.ibmPlexSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 24, height: 24),
                    ],
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
