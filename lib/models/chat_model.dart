class ChatModel {
  final String id;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageSenderId;
  final DateTime lastMessageReadAt;
  final DateTime createAt;
  final DateTime updateAt;

  ChatModel({
    required this.id,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageSenderId,
    required this.lastMessageReadAt,
    required this.createAt,
    required this.updateAt,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      lastMessage: map['lastMessage'],
      lastMessageTime: map['lastMessageTime'].toDate(),
      lastMessageSenderId: map['lastMessageSenderId'],
      lastMessageReadAt: map['lastMessageReadAt'].toDate(),
      createAt: map['createAt'].toDate(),
      updateAt: map['updateAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageReadAt': lastMessageReadAt,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }
}
