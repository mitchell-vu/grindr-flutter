import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttr/shared/services/auth_service.dart';

class SocialsLogin extends StatelessWidget {
  const SocialsLogin({super.key});

  void loginWithGoogle(BuildContext context) async {
    try {
      await authService.value.signInWithGoogle();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));

      debugPrint("Sign-in error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      spacing: 20,
      children: [
        ElevatedButton(
          onPressed: () => loginWithGoogle(context),
          child: Row(
            spacing: 8,
            mainAxisAlignment: .center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/svgs/google.svg'),
              ),
              Text('Sign in with Google'),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: () {},
          child: Row(
            spacing: 8,
            mainAxisAlignment: .center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/svgs/facebook.svg'),
              ),
              Text('Sign in with Facebook'),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: () {},
          child: Row(
            spacing: 8,
            mainAxisAlignment: .center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/svgs/apple.svg',
                  colorFilter: ColorFilter.mode(Colors.white, .srcIn),
                ),
              ),
              Text('Sign in with Apple'),
            ],
          ),
        ),
      ],
    );
  }
}
