import 'package:flutter/material.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/routing/pages.dart';
import 'package:fluttr/shared/widgets/section_heading.dart';
import 'package:fluttr/theme/color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum SettingItemType { text, bool }

final AuthController _authController = Get.find<AuthController>();

class SettingItem {
  final String label;
  final SettingItemType type;
  final String? value;
  final bool? boolValue;
  final VoidCallback? onTap;

  const SettingItem({
    required this.label,
    this.type = SettingItemType.text,
    this.value,
    this.boolValue,
    this.onTap,
  });
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout(BuildContext context) async {
    final confirm = await showAdaptiveDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text('Need to log out? No problem'),
          content: Text(
            'Click on log out below if you would like to log out. Your texts and photos will be available when you log back in.',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text('Log out', style: TextStyle(color: AppColors.error)),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await _authController.signOut();

    if (!context.mounted) return;

    Get.offAllNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsSection(
              title: 'Account',
              items: [
                SettingItem(
                  label: 'Email',
                  type: SettingItemType.text,
                  value: _authController.userModel!.email,
                  onTap: () {},
                ),
                SettingItem(
                  label: 'Password',
                  type: SettingItemType.text,
                  onTap: () {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Notifications',
              items: [
                SettingItem(
                  label: 'Received Taps',
                  type: SettingItemType.bool,
                  boolValue: true,
                ),
                SettingItem(
                  label: 'Sound',
                  type: SettingItemType.bool,
                  boolValue: true,
                ),
                SettingItem(
                  label: 'Vibrations',
                  type: SettingItemType.bool,
                  boolValue: true,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: SectionHeading(text: 'Actions'),
            ),
            Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () => logout(context),
                  child: Text('Logout'),
                ),
                FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.error),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: Text('Delete Profile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key, required this.title, required this.items});

  final String title;
  final List<SettingItem> items;

  @override
  Widget build(BuildContext context) {
    Widget trailingWidget(SettingItem item) {
      List<Widget> widgets = [];

      if (item.type == SettingItemType.bool) {
        widgets.add(
          Switch.adaptive(
            value: item.boolValue ?? false,
            onChanged: (value) {},
            activeTrackColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }

      if (item.type == SettingItemType.text && item.value != null) {
        widgets.add(Text(item.value!));
      }

      if (item.onTap != null) {
        widgets.add(Icon(Icons.arrow_forward_ios, size: 16));
      }

      return Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
          child: SectionHeading(text: title),
        ),
        Container(
          color: Color(0xFF1F1F20),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final item = entry.value;
              final isLast = entry.key == items.length - 1;

              return Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          item.label,
                          style: GoogleFonts.ibmPlexSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        trailingWidget(item),
                      ],
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                  ),
                  if (!isLast)
                    Divider(color: Color(0xFF434343), height: 1, indent: 16),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
