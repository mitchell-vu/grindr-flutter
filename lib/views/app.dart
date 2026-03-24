import 'package:flutter/material.dart';
import 'package:grindr_flutter/views/chat/chat.dart';
import 'package:grindr_flutter/views/home.dart';
import 'package:grindr_flutter/services/auth_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

final List<Map<String, dynamic>> _pages = [
  {'icon': Icons.home_outlined, 'selectedIcon': Icons.home, 'label': 'Home'},
  {
    'icon': Icons.water_drop_outlined,
    'selectedIcon': Icons.water_drop,
    'label': 'Right Now',
  },
  {
    'icon': Icons.remove_red_eye_outlined,
    'selectedIcon': Icons.remove_red_eye,
    'label': 'View',
  },
  {
    'icon': Icons.chat_bubble_outline,
    'selectedIcon': Icons.chat_bubble,
    'label': 'Chat',
  },
];

ValueNotifier<int> selectedPageIndex = ValueNotifier<int>(0);

class _AppState extends State<App> {
  void logout() async {
    await authService.value.signOut();

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageIndex,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_pages.elementAt(selectedPageIndex.value)['label']),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 16,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                        ),
                      ),
                      Text(
                        authService.value.currentUser?.displayName ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: logout,
                ),
              ],
            ),
          ),
          body: ValueListenableBuilder(
            valueListenable: selectedPageIndex,
            builder: (context, value, child) {
              switch (value) {
                case 0:
                  return Home();
                case 1:
                  return Center(
                    child: Text(
                      'Right Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                case 2:
                  return Center(
                    child: Text('View', style: TextStyle(color: Colors.white)),
                  );
                case 3:
                  return ChatPage();
                default:
                  return Home();
              }
            },
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: selectedPageIndex,
            builder: (context, value, child) {
              return NavigationBar(
                destinations: _pages
                    .map(
                      (page) => NavigationDestination(
                        icon: Icon(page['icon']),
                        selectedIcon: Icon(page['selectedIcon']),
                        label: page['label'],
                      ),
                    )
                    .toList(),
                selectedIndex: selectedPageIndex.value,
                onDestinationSelected: (value) {
                  selectedPageIndex.value = value;
                },
              );
            },
          ),
        );
      },
    );
  }
}
