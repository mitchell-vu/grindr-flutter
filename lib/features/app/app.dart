import 'package:flutter/material.dart';
import 'package:grindr_flutter/features/chat/views/chat.dart';
import 'package:grindr_flutter/features/home/home.dart';
import 'package:grindr_flutter/shared/services/auth_service.dart';

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
    'label': 'Inbox',
  },
];

ValueNotifier<int> selectedPageIndex = ValueNotifier<int>(0);

class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
          key: _scaffoldKey,
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(_pages.elementAt(selectedPageIndex.value)['label']),
            leading: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    currentUser.value?.photoUrl ??
                        'https://static.wikia.nocookie.net/marias/images/9/95/CINEMA.jpg/revision/latest/scale-to-width-down/1200?cb=20250708183259',
                  ),
                ),
              ),
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          drawer: Drawer(
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
                          SizedBox(
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
                backgroundColor: Colors.black,
                destinations: _pages
                    .map(
                      (page) => NavigationDestination(
                        icon: Icon(page['icon']),
                        selectedIcon: Icon(page['selectedIcon']),
                        label: page['label'],
                      ),
                    )
                    .toList(),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
