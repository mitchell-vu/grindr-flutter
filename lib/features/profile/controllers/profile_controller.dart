import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/models/user_model.dart';
import 'package:fluttr/shared/services/firestore_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final FirestoreService _firestoreService = FirestoreService();

  final Rx<UserModel?> user = Rxn<UserModel>();

  Future<UserModel?> getUser(String uid) async {
    user.value = await _firestoreService.getUser(uid);
    return user.value;
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await _firestoreService.updateUser(uid, data);

    _authController.updateUserModel(
      _authController.userModel!.copyWith(
        displayName: data['displayName'],
        bio: data['bio'],
        showAge: data['showAge'],
        showPosition: data['showPosition'],
        age: data['age'],
        height: data['height'],
        weight: data['weight'],
        bodyType: data['bodyType'],
        position: data['position'],
        ethnicity: data['ethnicity'],
        relationshipStatus: data['relationshipStatus'],
      ),
    );
  }
}
