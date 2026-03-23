import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grindr_flutter/pages/app.dart';
import 'package:grindr_flutter/services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void signUp() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    try {
      await authService.value.signUpWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const App()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'There was an error')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Confirm Password',
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: FilledButton(
                onPressed: signUp,
                child: const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
