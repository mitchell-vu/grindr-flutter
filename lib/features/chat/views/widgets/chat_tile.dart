import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grindr_flutter/configs/theme.dart';
import 'package:grindr_flutter/shared/utils/page_transaction.dart';
import 'package:grindr_flutter/features/chat/views/chat_history.dart';
import 'package:grindr_flutter/features/profile/profile.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });

  final String avatarUrl;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final isUnread = unreadCount > 0;
    final isOnline = Random().nextInt(10) > 5;
    final contentColor = isUnread ? Colors.white : Colors.grey;

    return Row(
      children: [
        // Avatar
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(context, slideToTopPageTransaction(ProfilePage()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                avatarUrl,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatHistoryPage(title: name),
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
                            name,
                            style: TextStyle(fontSize: 16, color: contentColor),
                          ),
                        ],
                      ),
                      Text(
                        lastMessage,
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
                        time,
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
