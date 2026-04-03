import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:fluttr/routing/pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AuthController _authController = Get.put(
    AuthController(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
    checkAuth();
  }

  void checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    if (_authController.isAuthenticated) {
      Get.offAllNamed(Routes.app);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
