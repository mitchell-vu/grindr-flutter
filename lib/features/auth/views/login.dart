import 'package:flutter/material.dart';
import 'package:fluttr/features/auth/views/widgets/socials_login.dart';
import 'package:get/get.dart';
import 'package:fluttr/features/auth/controllers/login_controller.dart';
import 'package:fluttr/routing/pages.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Get.toNamed(Routes.signUp);
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
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
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: controller.login,
                child: Text('Login'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: Text('Forgot Password'),
              ),
            ),
            SizedBox(height: 24),
            SocialsLogin(onLoginGoogle: controller.loginWithGoogle),
          ],
        ),
      ),
    );
  }
}
