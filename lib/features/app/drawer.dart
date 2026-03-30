import 'package:flutter/material.dart';
import 'package:fluttr/features/profile/views/edit_profile.dart';
import 'package:fluttr/features/profile/views/profile.dart';
import 'package:fluttr/features/settings/settings.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:fluttr/shared/utils/page_transaction.dart';
import 'package:fluttr/shared/widgets/avatar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const .all(8.0),
            child: ValueListenableBuilder(
              valueListenable: currentUser,
              builder: (context, value, child) {
                return Column(
                  spacing: 16,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          slideToTopPageTransition(
                            ProfilePage(uid: currentUser.value!.uid),
                          ),
                        );
                      },
                      child: Avatar(
                        url: currentUser.value!.photoUrl,
                        size: 120,
                        radius: 6,
                      ),
                    ),

                    Container(
                      padding: const .only(
                        left: 16,
                        right: 2,
                        top: 2,
                        bottom: 2,
                      ),
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
                                text: currentUser.value?.displayName,
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
                );
              },
            ),
          ),

          ListTile(
            leading: Icon(Icons.edit, color: Colors.grey),
            title: Text('Edit Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
