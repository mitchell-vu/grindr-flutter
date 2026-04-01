import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttr/features/chat/models/message_model.dart';

class ChatModel {
  final String id;
  final List<String> participantIds;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final String? lastMessageSenderId;
  final MessageType? lastMessageType;
  final DateTime? lastMessageReadAt;
  final DateTime createAt;
  final DateTime updateAt;

  ChatModel({
    required this.id,
    required this.participantIds,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageSenderId,
    this.lastMessageType = MessageType.text,
    this.lastMessageReadAt,
    required this.createAt,
    required this.updateAt,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      participantIds: List<String>.from(map['participantIds'] ?? []),
      lastMessage: map['lastMessage'],
      lastMessageTime: (map['lastMessageTime'] as Timestamp?)?.toDate(),
      lastMessageType: map['lastMessageType'] != null
          ? MessageType.values.byName(map['lastMessageType'])
          : MessageType.text,
      lastMessageSenderId: map['lastMessageSenderId'],
      lastMessageReadAt: (map['lastMessageReadAt'] as Timestamp?)?.toDate(),
      createAt: (map['createAt'] as Timestamp).toDate(),
      updateAt: (map['updateAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participantIds': participantIds,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageType': lastMessageType?.name,
      'lastMessageReadAt': lastMessageReadAt,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }
}
