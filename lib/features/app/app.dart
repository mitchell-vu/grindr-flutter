import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttr/configs/theme.dart';
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
          backgroundColor: Colors.black,
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
              return BottomAppBar(
                color: Colors.black,
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _pages
                      .map(
                        (page) => IconButton(
                          iconSize: 28,
                          padding: EdgeInsets.zero,

                          icon: Icon(page['icon'], color: Colors.grey),
                          selectedIcon: Icon(
                            page['selectedIcon'],
                            color: AppTheme.primary,
                          ),
                          isSelected: value == _pages.indexOf(page),
                          onPressed: () {
                            selectedPageIndex.value = _pages.indexOf(page);
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
