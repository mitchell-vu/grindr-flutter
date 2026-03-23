import 'package:flutter/material.dart';
import 'package:grindr_flutter/pages/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final List<Map<String, dynamic>> _pages = [
  {'icon': Icons.grid_view, 'label': 'Grid'},
  {'icon': Icons.list_alt, 'label': 'List'},
  {'icon': Icons.remove_red_eye_outlined, 'label': 'View'},
  {'icon': Icons.chat_bubble_outline, 'label': 'Chat'},
];

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: [
          ...List.generate(33, (index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: _pages
            .map(
              (page) => NavigationDestination(
                icon: Icon(page['icon']),
                label: page['label'],
              ),
            )
            .toList(),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
