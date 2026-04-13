import 'package:flutter/material.dart';
import 'package:fluttr/features/app/views/widgets/drawer.dart';
import 'package:fluttr/features/chat/views/chat_list.dart';
import 'package:fluttr/features/home/home.dart';
import 'package:fluttr/features/interest/views/views.dart';
import 'package:get/get.dart';
import 'package:fluttr/features/app/controllers/app_controller.dart';

class App extends GetView<AppController> {
  App({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        body: _buildBody(controller.selectedPageIndex.value),
        bottomNavigationBar: AppBottomNavBar(
          selectedIndex: controller.selectedPageIndex.value,
          onPageSelected: controller.changePage,
        ),
      ),
    );
  }

  Widget _buildBody(int value) {
    switch (value) {
      case 1:
      case 2:
        return const ViewsPage();
      case 3:
        return const ChatListPage();
      case 0:
      default:
        return Home(
          onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
        );
    }
  }
}

final List<Map<String, dynamic>> _pages = [
  {'icon': Icons.home_outlined, 'selectedIcon': Icons.home},
  {'icon': Icons.water_drop_outlined, 'selectedIcon': Icons.water_drop},
  {'icon': Icons.remove_red_eye_outlined, 'selectedIcon': Icons.remove_red_eye},
  {'icon': Icons.chat_bubble_outline, 'selectedIcon': Icons.chat_bubble},
];

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onPageSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      height: 64,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: _pages
            .map(
              (page) => Expanded(
                child: IconButton(
                  iconSize: 28,
                  padding: EdgeInsets.zero,
                  icon: Icon(page['icon'], color: Colors.grey.shade600),
                  selectedIcon: Icon(
                    page['selectedIcon'],
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  isSelected: selectedIndex == _pages.indexOf(page),
                  onPressed: () {
                    onPageSelected(_pages.indexOf(page));
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
