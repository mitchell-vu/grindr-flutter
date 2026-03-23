import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grindr_flutter/views/chat/chat_history.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final isUnread = unreadCount > 0;
    final isOnline = Random().nextInt(10) > 5;
    final contentColor = isUnread
        ? colorScheme.onSurface
        : colorScheme.onSurfaceVariant;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatHistoryPage(title: name)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                avatarUrl,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),

            // Name + message
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
                        Icon(Icons.circle, size: 12, color: Colors.green),
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
            const SizedBox(width: 8),

            // Time + unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 8,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                if (isUnread)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$unreadCount',
                      style: GoogleFonts.ibmPlexSans(
                        color: colorScheme.onPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 24, height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
