import 'package:flutter/material.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/features/home/widgets/user_tile.dart';
import 'package:fluttr/shared/data.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:fluttr/shared/services/firestore_service.dart';
import 'package:fluttr/shared/widgets/avatar.dart';
import 'package:fluttr/shared/widgets/no_result.dart';
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
            padding: .symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: .stretch,
              spacing: 8,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onOpenDrawer?.call();
                      },
                      child: ValueListenableBuilder(
                        valueListenable: currentUser,
                        builder: (context, value, child) {
                          return Avatar(
                            url: currentUser.value!.photoUrl,
                            size: 44,
                            rounded: true,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 44,
                        alignment: .centerLeft,
                        padding: .symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: .circular(24),
                          color: Theme.of(context).colorScheme.surfaceBright,
                        ),
                        child: Row(
                          crossAxisAlignment: .center,
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

                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: UsersFilter(),
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
                            borderRadius: .circular(6),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }

              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return NoResult();
              }

              return CustomScrollView(
                slivers: [
                  SliverGrid.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    children: [
                      ...snapshot.data!.map((user) {
                        return UserTile(user: user);
                      }),
                      ...List.generate(24, (index) {
                        return UserTile(user: mockUser);
                      }),
                    ],
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

class UsersFilter extends StatelessWidget {
  const UsersFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        ChoiceChip(
          label: Text(
            "Online",
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: false,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text(
            "Age",
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: false,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text(
            "Height",
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: false,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text(
            "Has photos",
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: false,
          onSelected: (value) {},
        ),
        ChoiceChip(
          label: Text(
            "Popular",
            style: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: .w500),
          ),
          selected: false,
          onSelected: (value) {},
        ),
      ],
    );
  }
}
