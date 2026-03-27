import 'package:flutter/material.dart';
import 'package:grindr_flutter/features/app/app.dart';
import 'package:grindr_flutter/features/auth/views/login.dart';
import 'package:grindr_flutter/shared/services/auth_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }

            if (snapshot.hasData) {
              if (currentUser.value == null) {
                AuthService().firestoreService.getUser(snapshot.data!.uid).then(
                  (user) {
                    currentUser.value = user;
                  },
                );
              }

              FlutterNativeSplash.remove();
              return App();
            }

            FlutterNativeSplash.remove();
            currentUser.value = null;
            return Login();
          },
        );
      },
    );
  }
}
