import 'package:flutter/material.dart';
import 'package:grindr_flutter/shared/utils/page_transaction.dart';
import 'package:grindr_flutter/features/profile/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: [
          ...List.generate(33, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).push(slideToTopPageTransaction(const ProfilePage()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    Image.network(
                      'https://static.wikia.nocookie.net/marias/images/9/95/CINEMA.jpg/revision/latest/scale-to-width-down/1200?cb=20250708183259',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.9),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.4],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.circle, color: Colors.green, size: 12),
                          Text(
                            "The Mariás",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
