import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grindr_flutter/features/chat/models/chat_model.dart';
import 'package:grindr_flutter/features/auth/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: ${e.toString()}');
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }

      return null;
    } catch (e) {
      throw Exception('Failed to get user: ${e.toString()}');
    }
  }

  Stream<List<ChatModel>> getChatStream(String uid) {
    try {
      return _firestore
          .collection('chats')
          .where('participants', arrayContains: uid)
          .orderBy('updateAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => ChatModel.fromMap(doc.data()))
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to get or create chat: ${e.toString()}');
    }
  }
}

String _generateChatId(String user1, String user2) {
  final List<String> users = [user1, user2];
  users.sort();
  return users.join('_');
}
