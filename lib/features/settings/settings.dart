import 'package:flutter/material.dart';
import 'package:fluttr/configs/theme.dart';
import 'package:fluttr/shared/services/auth_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout(BuildContext context) async {
    await authService.value.signOut();

    if (!context.mounted) return;

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Account'.toUpperCase(),
              style: TextStyle(
                fontWeight: .bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 24),

            Text(
              'Notification'.toUpperCase(),
              style: TextStyle(
                fontWeight: .bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 24),
            Text(
              'Actions'.toUpperCase(),
              style: TextStyle(fontWeight: .bold, color: Colors.grey),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => logout(context),
                child: Text('Logout'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppTheme.error),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                child: Text('Delete Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
