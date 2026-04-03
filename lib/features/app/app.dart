import 'package:flutter/material.dart';
import 'package:fluttr/features/app/drawer.dart';
import 'package:fluttr/features/chat/views/chat_list.dart';
import 'package:fluttr/features/home/home.dart';
import 'package:fluttr/features/interest/views/views.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

final List<Map<String, dynamic>> _pages = [
  {'icon': Icons.home_outlined, 'selectedIcon': Icons.home},
  {'icon': Icons.water_drop_outlined, 'selectedIcon': Icons.water_drop},
  {'icon': Icons.remove_red_eye_outlined, 'selectedIcon': Icons.remove_red_eye},
  {'icon': Icons.chat_bubble_outline, 'selectedIcon': Icons.chat_bubble},
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
          drawer: AppDrawer(),
          body: ValueListenableBuilder(
            valueListenable: selectedPageIndex,
            builder: (context, value, child) {
              switch (value) {
                case 1:
                case 2:
                  return ViewsPage();
                case 3:
                  return ChatListPage();
                case 0:
                default:
                  return Home(
                    onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
                  );
              }
            },
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: selectedPageIndex,
            builder: (context, value, child) {
              return AppBottomNavBar(selectedIndex: value);
            },
          ),
        );
      },
    );
  }
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: .zero,
      height: 64,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: _pages
            .map(
              (page) => Expanded(
                child: IconButton(
                  iconSize: 28,
                  padding: .zero,
                  icon: Icon(page['icon'], color: Colors.grey.shade600),
                  selectedIcon: Icon(
                    page['selectedIcon'],
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  isSelected: selectedIndex == _pages.indexOf(page),
                  onPressed: () {
                    selectedPageIndex.value = _pages.indexOf(page);
                  },
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
