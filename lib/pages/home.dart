import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
    );
  }
}
