import 'package:flutter/material.dart';
import 'package:grindr_flutter/configs/theme.dart';
import 'package:grindr_flutter/features/chat/models/message_model.dart';
import 'package:grindr_flutter/shared/services/auth_service.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    this.showTimestamp = false,
  });

  final MessageModel message;
  final bool showTimestamp;

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == currentUser.value!.uid;
    final bubbleColor = isMe ? AppTheme.primary : AppTheme.secondary;

    return Container(
      alignment: message.senderId == currentUser.value!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // The main bubble
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(8),
                        topRight: const Radius.circular(8),
                        bottomLeft: isMe
                            ? const Radius.circular(8)
                            : Radius.zero,
                        bottomRight: isMe
                            ? Radius.zero
                            : const Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      message.content,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Triangle tail
                  Positioned(
                    bottom: 0,
                    left: isMe ? null : -8,
                    right: isMe ? -8 : null,
                    child: CustomPaint(
                      size: const Size(10, 12),
                      painter: _BubbleTailPainter(
                        color: bubbleColor,
                        isMe: isMe,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            showTimestamp
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '${message.createdAt.hour.toString().padLeft(2, '0')}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  const _BubbleTailPainter({required this.color, required this.isMe});

  final Color color;
  final bool isMe;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (isMe) {
      // Tail points to the bottom-right
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      // Tail points to the bottom-left
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BubbleTailPainter oldDelegate) =>
      color != oldDelegate.color || isMe != oldDelegate.isMe;
}
