import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttr/features/chat/models/attachment_model.dart';
import 'package:fluttr/features/chat/models/chat_model.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/features/chat/models/message_model.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:fluttr/shared/services/firestore_service.dart';
import 'package:fluttr/shared/services/upload_service.dart';
import 'package:image_picker/image_picker.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<({ChatModel chat, UserModel user})>> getChatListWithUsers(
    String selfId,
  ) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('chats')
          .where('participantIds', arrayContains: selfId)
          .get();

      final chats = snapshot.docs
          .map((doc) => ChatModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return Future.wait(
        chats.map((chat) async {
          final otherId = chat.participantIds.firstWhere((id) => id != selfId);
          final user = await FirestoreService().getUser(otherId);

          return (chat: chat, user: user!);
        }),
      );
    } catch (e) {
      throw Exception('Failed to get chat list: ${e.toString()}');
    }
  }

  Future<ChatModel> getOrCreateChat(String selfId, String otherId) async {
    try {
      final chatId = generateChatId(selfId, otherId);
      final docSnapshot = await _firestore
          .collection('chats')
          .doc(chatId)
          .get();

      if (docSnapshot.exists) {
        return ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
      } else {
        final newChat = ChatModel(
          id: chatId,
          participantIds: [selfId, otherId],
          createAt: DateTime.now(),
          updateAt: DateTime.now(),
        );

        await _firestore.collection('chats').doc(chatId).set(newChat.toMap());
        return newChat;
      }
    } catch (e) {
      throw Exception('Failed to get or create chat: ${e.toString()}');
    }
  }

  Stream<List<MessageModel>> getChatStream(String chatId) {
    try {
      return _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => MessageModel.fromMap(doc.data()))
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to get or create chat: ${e.toString()}');
    }
  }

  Future<void> sendMessage(
    String selfId,
    String otherId,
    MessageModel message,
  ) async {
    try {
      ChatModel chat = await getOrCreateChat(selfId, otherId);

      await _firestore
          .collection('chats')
          .doc(chat.id)
          .collection('messages')
          .add(message.toMap());

      await _firestore.collection('chats').doc(chat.id).update({
        'lastMessage': message.content,
        'lastMessageTime': message.createdAt,
        'lastMessageType': message.type.name,
        'lastMessageSenderId': message.senderId,
        'updateAt': DateTime.now(),
      });
    } catch (e) {
      throw Exception('Failed to send message: ${e.toString()}');
    }
  }

  Future<void> sendMessageWithImage(
    String selfId,
    String otherId,
    XFile imageXFile,
  ) async {
    AttachmentModel? attachment;

    final File imageFile = File(imageXFile.path);
    final decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());

    UploadService.upload(
      // TODO: taskId = Current message ID with Pending status
      taskId: DateTime.now().millisecondsSinceEpoch.toString(),
      file: File(imageFile.path),
      path: 'attachments/${currentUser.value!.uid}/${imageXFile.name}',
      onUploadDone: (snapshot) async {
        final url = await snapshot.ref.getDownloadURL();

        attachment = AttachmentModel(
          fileName: snapshot.ref.name,
          type: .image,
          width: decodedImage.width,
          height: decodedImage.height,
          url: url,
        );

        final newMessage = MessageModel(
          senderId: currentUser.value!.uid,
          content: '',
          type: .image,
          attachment: attachment,
          isRead: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await sendMessage(selfId, otherId, newMessage);
      },
      onUploadError: () {},
    );
  }
}

String generateChatId(String user1, String user2) {
  final List<String> users = [user1, user2];
  users.sort();

  return users.join('_');
}
