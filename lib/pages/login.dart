import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grindr_flutter/pages/sign_up.dart';
import 'package:grindr_flutter/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    try {
      await authService.value.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'There was an error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUp()),
              );
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
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
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: FilledButton(onPressed: login, child: const Text('Login')),
            ),
          ],
        ),
      ),
    );
  }
}
