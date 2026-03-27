import 'package:flutter/material.dart';
import 'package:grindr_flutter/shared/services/auth_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout(BuildContext context) async {
    await authService.value.signOut();

    if (!context.mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account'.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 24),

            Text(
              'Notification'.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 24),
            Text(
              'Actions'.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
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
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
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
