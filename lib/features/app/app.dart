import 'package:flutter/material.dart';
import 'package:grindr_flutter/features/app/drawer.dart';
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
          drawer: AppDrawer(),
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
