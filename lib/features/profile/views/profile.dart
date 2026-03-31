import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/features/profile/views/widgets/about_me_section.dart';
import 'package:fluttr/features/profile/views/widgets/action_bar.dart';
import 'package:fluttr/features/profile/views/widgets/chat_bottom.dart';
import 'package:fluttr/features/profile/views/widgets/profile_stats.dart';
import 'package:fluttr/shared/data.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:fluttr/shared/services/firestore_service.dart';
import 'package:fluttr/shared/utils/top_clamped_scroll_physics.dart';
import 'package:fluttr/shared/widgets/avatar.dart';
import 'package:fluttr/theme/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.uid});
  final String? uid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  late final bool isMe;

  int currentPhotoIndex = 0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    isMe = widget.uid == currentUser.value?.uid;
    _loadUser();
  }

  Future<void> _loadUser() async {
    if (widget.uid != null) {
      final fetchedUser = await FirestoreService().getUser(widget.uid!);

      setState(() {
        user = fetchedUser ?? mockUser;
      });
    } else {
      setState(() {
        user = mockUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  physics: const TopClampedScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Stack(
                        children: [
                          Avatar(
                            url: user!.photoUrl,
                            width: double.infinity,
                            height: 640,
                            radius: 0,
                          ),

                          Positioned.fill(
                            child: Align(
                              alignment: .centerRight,
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  Container(
                                    margin: const .all(16),
                                    padding: const .symmetric(
                                      vertical: 14,
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.25,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: .center,
                                      spacing: 6,
                                      children: [
                                        ...List.generate(3, (index) {
                                          final isSelected =
                                              index == currentPhotoIndex;

                                          return Container(
                                            width: 6,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(
                                                alpha: isSelected ? 1 : 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          );
                                        }),
                                        Padding(
                                          padding: const .only(top: 4),
                                          child: Icon(
                                            Icons.lock,
                                            size: 16,
                                            color: Colors.white.withValues(
                                              alpha: currentPhotoIndex == 3
                                                  ? 1
                                                  : 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SafeArea(
                        top: false,
                        child: Padding(
                          padding: const .only(
                            left: 20,
                            right: 20,
                            top: 16,
                            bottom: 110,
                          ),
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: .start,
                            children: [
                              Row(
                                spacing: 8,
                                crossAxisAlignment: .end,
                                children: [
                                  Text(
                                    user!.displayName ?? "",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 28,
                                      fontWeight: .bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (user!.showAge == true &&
                                      user!.age != null &&
                                      user!.age!.isNotEmpty)
                                    Text(
                                      user!.age!,
                                      style: GoogleFonts.ibmPlexSans(
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),

                              Row(
                                spacing: 12,
                                children: [
                                  Row(
                                    spacing: 4,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: AppColors.success,
                                        size: 14,
                                      ),
                                      Text(
                                        "Online now",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.success,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    spacing: 4,
                                    children: [
                                      Icon(
                                        Icons.navigation_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      Text(
                                        "152m away",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              QuickStatsStrip(user: user!),

                              SizedBox(height: 24),

                              user?.bio != null && user!.bio!.trim().isNotEmpty
                                  ? AboutMeSection(bio: user!.bio!)
                                  : SizedBox.shrink(),

                              SizedBox(height: 24),
                              DetailedStatsSection(user: user!),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ActionBar(
                  isFavorite: isFavorite,
                  onToggleFavorite: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),

                ChatBottom(isMe: isMe, uid: user!.uid),
              ],
            ),
    );
  }
}
