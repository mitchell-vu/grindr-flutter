import 'package:fluttr/shared/services/firestore_service.dart';

class UserService {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await _firestoreService.updateUser(uid, data);
  }
}
