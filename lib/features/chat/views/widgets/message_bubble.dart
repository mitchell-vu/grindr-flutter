import 'package:flutter/material.dart';
import 'package:fluttr/features/chat/models/message_model.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

const double _bubbleRadius = 6.0;
const double _bubbleTailWidth = 8.0;
const double _bubbleTailHeight = 12.0;

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
            ClipPath(
              clipper: _BubbleClipper(isMe: isMe),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 250),
                color: bubbleColor,
                padding: message.type == .image
                    ? .zero
                    : .only(
                        left: isMe ? 16 : _bubbleTailWidth + 16,
                        right: isMe ? _bubbleTailWidth + 16 : 16,
                        top: 12,
                        bottom: 12,
                      ),
                child: message.type == MessageType.image
                    ? Image.network(message.attachment!.url, fit: .cover)
                    : Text(
                        message.content,
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 16,
                          fontWeight: .w500,
                        ),
                      ),
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

class _BubbleClipper extends CustomClipper<Path> {
  final bool isMe;
  const _BubbleClipper({required this.isMe});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (isMe) {
      final mainRect = Rect.fromLTRB(
        0,
        0,
        size.width - _bubbleTailWidth,
        size.height,
      );
      path.addRRect(
        RRect.fromRectAndCorners(
          mainRect,
          topLeft: .circular(_bubbleRadius),
          topRight: .circular(_bubbleRadius),
          bottomLeft: .circular(_bubbleRadius),
          bottomRight: .zero,
        ),
      );

      final tailPath = Path();
      tailPath.moveTo(
        size.width - _bubbleTailWidth - 2,
        size.height - _bubbleTailHeight,
      );
      tailPath.lineTo(size.width, size.height);
      tailPath.lineTo(size.width - _bubbleTailWidth - 2, size.height);
      tailPath.close();

      path.addPath(tailPath, Offset.zero);
    } else {
      final mainRect = Rect.fromLTRB(
        _bubbleTailWidth,
        0,
        size.width,
        size.height,
      );
      path.addRRect(
        RRect.fromRectAndCorners(
          mainRect,
          topLeft: .circular(_bubbleRadius),
          topRight: .circular(_bubbleRadius),
          bottomLeft: .zero,
          bottomRight: .circular(_bubbleRadius),
        ),
      );

      final tailPath = Path();
      tailPath.moveTo(_bubbleTailWidth + 2, size.height - _bubbleTailHeight);
      tailPath.lineTo(_bubbleTailWidth + 2, size.height);
      tailPath.lineTo(0, size.height);
      tailPath.close();

      path.addPath(tailPath, Offset.zero);
    }
    return path;
  }

  @override
  bool shouldReclip(_BubbleClipper oldClipper) => isMe != oldClipper.isMe;
}
