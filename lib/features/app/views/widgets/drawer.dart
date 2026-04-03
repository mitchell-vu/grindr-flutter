import 'package:flutter/material.dart';
import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/routing/pages.dart';
import 'package:fluttr/shared/widgets/avatar.dart';
import 'package:get/get.dart';

final AuthController _authController = Get.find<AuthController>();

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const .all(8.0),
            child: Column(
              spacing: 16,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      Routes.profile,
                      arguments: {'uid': _authController.userModel!.uid},
                    );
                  },
                  child: Avatar(
                    url: _authController.userModel!.photoUrl,
                    size: 120,
                    radius: 6,
                  ),
                ),

                Container(
                  padding: const .only(left: 16, right: 2, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(
                            text: _authController.userModel!.displayName,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Say something...',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.edit, color: Colors.grey),
            title: Text('Edit Profile'),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.editProfile);
            },
          ),

          ListTile(
            leading: Icon(Icons.photo, color: Colors.grey),
            title: Text('My Albums'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey),
            title: Text('Settings'),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.settings);
            },
          ),
        ],
      ),
    );
  }
}
