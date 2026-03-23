import 'package:flutter/material.dart';
import 'package:grindr_flutter/pages/home.dart';
import 'package:grindr_flutter/pages/login.dart';
import 'package:grindr_flutter/services/auth_service.dart';

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
            if (snapshot.hasData) {
              return Home();
            }
            return Login();
          },
        );
      },
    );
  }
}
