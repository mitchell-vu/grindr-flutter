import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/routing/pages.dart';

class SignUpController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void signUp() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    await _authController.signUpWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    if (_authController.isAuthenticated) {
      Get.snackbar('Success', 'Account created!');
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
