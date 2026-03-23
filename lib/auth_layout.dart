import 'package:flutter/material.dart';
import 'package:grindr_flutter/pages/app.dart';
import 'package:grindr_flutter/pages/login.dart';
import 'package:grindr_flutter/services/auth_service.dart';
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

            FlutterNativeSplash.remove();

            if (snapshot.hasData) {
              return App();
            }
            return Login();
          },
        );
      },
    );
  }
}
