import 'package:flutter/material.dart';
import 'package:grindr_flutter/configs/theme.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.content, required this.isMe});

  final String content;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? AppTheme.primary : AppTheme.secondary;

    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // The main bubble
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8),
                  bottomLeft: isMe ? const Radius.circular(8) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : const Radius.circular(8),
                ),
              ),
              child: Text(
                content,
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
                painter: _BubbleTailPainter(color: bubbleColor, isMe: isMe),
              ),
            ),
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
