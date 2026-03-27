import 'package:flutter/material.dart';
import 'package:grindr_flutter/features/profile/profile.dart';
import 'package:grindr_flutter/features/settings/settings.dart';
import 'package:grindr_flutter/shared/services/auth_service.dart';
import 'package:grindr_flutter/shared/utils/page_transaction.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                          slideToTopPageTransaction(ProfilePage(isMe: true)),
                        );
                      },
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            currentUser.value?.photoUrl ??
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 2,
                        top: 2,
                        bottom: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
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
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.photo),
            title: Text('My Albums'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.settings),
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
