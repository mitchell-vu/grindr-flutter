import 'package:flutter/material.dart';
import 'package:grindr_flutter/features/auth/models/user_model.dart';
import 'package:grindr_flutter/features/home/user_tile.dart';
import 'package:grindr_flutter/shared/services/auth_service.dart';
import 'package:grindr_flutter/shared/services/firestore_service.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.onOpenDrawer});

  final VoidCallback? onOpenDrawer;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<UserModel>> users;

  @override
  void initState() {
    super.initState();
    users = FirestoreService().getAllOtherUsers(currentUser.value!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              spacing: 12,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onOpenDrawer?.call();
                  },
                  child: ValueListenableBuilder(
                    valueListenable: currentUser,
                    builder: (context, value, child) {
                      return CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          currentUser.value?.photoUrl ??
                              'https://static.wikia.nocookie.net/marias/images/9/95/CINEMA.jpg/revision/latest/scale-to-width-down/1200?cb=20250708183259',
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 44,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Icon(Icons.search, color: Colors.grey.shade300),
                        Text(
                          "Explore more profiles",
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: users,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomScrollView(
                  slivers: [
                    SliverGrid.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      children: List.generate(24, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }

              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No results",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Try changing your filters",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverGrid.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    children: snapshot.data!.map((user) {
                      return UserTile(user: user);
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
