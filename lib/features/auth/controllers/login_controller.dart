import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/routing/pages.dart';

class LoginController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
      return;
    }

    await _authController.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    if (_authController.isAuthenticated) {
      Get.offAllNamed(Routes.app);
    }
  }

  void loginWithGoogle() async {
    await _authController.signInWithGoogle();
    if (_authController.isAuthenticated) {
      Get.offAllNamed(Routes.app);
    }
  }
}
