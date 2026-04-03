import 'package:get/get.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/features/auth/controllers/login_controller.dart';
import 'package:fluttr/features/auth/controllers/sign_up_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
