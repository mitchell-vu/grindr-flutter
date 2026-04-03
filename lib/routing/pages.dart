import 'package:camera/camera.dart';
import 'package:fluttr/features/camera/views/camera.dart';
import 'package:get/get.dart';
import 'package:fluttr/features/app/views/app.dart';
import 'package:fluttr/splash.dart';
import 'package:fluttr/features/auth/views/login.dart';
import 'package:fluttr/features/auth/views/sign_up.dart';
import 'package:fluttr/features/chat/views/chat.dart';
import 'package:fluttr/features/profile/views/profile.dart';
import 'package:fluttr/features/profile/views/edit_profile.dart';
import 'package:fluttr/features/settings/settings.dart';
import 'package:fluttr/features/app/bindings/app_binding.dart';
import 'package:fluttr/features/auth/bindings/auth_binding.dart';
import 'package:fluttr/features/chat/bindings/chat_binding.dart';
import 'package:fluttr/features/profile/controllers/profile_binding.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUp(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.app,
      page: () => App(),
      bindings: [AppBinding(), ChatBinding()],
    ),
    GetPage(
      name: Routes.chat,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final otherUserId = args?['otherUserId'] as String? ?? '';
        return ChatPage(otherUserId: otherUserId);
      },
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final uid = args?['uid'] as String? ?? '';
        return ProfilePage(uid: uid);
      },
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => const EditProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(name: Routes.settings, page: () => const SettingsPage()),
    GetPage(
      name: Routes.camera,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final type = args?['type'] as CameraType? ?? CameraType.photo;
        final cameras = args?['cameras'] as List<CameraDescription>? ?? [];
        return CameraView(type: type, cameras: cameras);
      },
    ),
  ];
}
