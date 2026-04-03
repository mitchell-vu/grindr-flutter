import 'package:flutter/material.dart';
import 'package:fluttr/features/auth/views/widgets/socials_login.dart';
import 'package:get/get.dart';
import 'package:fluttr/features/auth/controllers/sign_up_controller.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Container(
        padding: .all(16),
        child: Column(
          spacing: 16,
          children: [
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            TextField(
              controller: controller.confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Confirm Password',
              ),
            ),
            SizedBox(
              width: .infinity,
              child: FilledButton(
                onPressed: controller.signUp,
                child: Text('Create Account'),
              ),
            ),

            SizedBox(height: 24),

            Align(
              alignment: .centerLeft,
              child: Text(
                'Or login with'.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: .w600,
                ),
              ),
            ),
            SocialsLogin(
              onLoginGoogle: controller.loginWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}
