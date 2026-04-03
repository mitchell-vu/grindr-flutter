import 'package:get/get.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/models/user_model.dart';
import 'package:fluttr/shared/services/firestore_service.dart';

class HomeController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final currentUid = _authController.userModel!.uid;
      final result = await FirestoreService().getAllOtherUsers(currentUid);

      users.value = result;
    } catch (e) {
      hasError.value = true;
      print('Error fetching home users: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
