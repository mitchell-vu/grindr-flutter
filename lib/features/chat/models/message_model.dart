import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttr/features/chat/models/attachment_model.dart';

enum MessageType { text, image }

class MessageModel {
  final String senderId;
  final String content;
  final MessageType type;
  final AttachmentModel? attachment;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.senderId,
    required this.content,
    required this.type,
    this.attachment,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      content: map['content'],
      type: MessageType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => MessageType.text,
      ),
      attachment: map['attachment'] != null
          ? AttachmentModel.fromMap(map['attachment'])
          : null,
      isRead: map['isRead'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'content': content,
      'type': type.name,
      'attachment': attachment?.toMap(),
      'isRead': isRead,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
