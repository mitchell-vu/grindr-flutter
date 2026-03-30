import 'package:flutter/material.dart';
import 'package:fluttr/features/chat/models/message_model.dart';
import 'package:fluttr/shared/services/auth_service.dart';

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
    final bubbleColor = isMe
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    return Container(
      alignment: message.senderId == currentUser.value!.uid
          ? .centerRight
          : .centerLeft,
      child: Padding(
        padding: .symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: isMe ? .end : .start,
          children: [
            Padding(
              padding: .only(left: 10.0, right: 10.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // The main bubble
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    padding: .symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.only(
                        topLeft: .circular(8),
                        topRight: .circular(8),
                        bottomLeft: isMe ? .circular(8) : .zero,
                        bottomRight: isMe ? .zero : .circular(8),
                      ),
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(fontSize: 16, fontWeight: .bold),
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
                    padding: .symmetric(vertical: 4),
                    child: Text(
                      '${message.createdAt.hour.toString().padLeft(2, '0')}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
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
