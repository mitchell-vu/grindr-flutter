import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttr/configs/theme.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/features/chat/views/chat.dart';
import 'package:fluttr/shared/data.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:fluttr/shared/services/firestore_service.dart';
import 'package:fluttr/shared/widgets/avatar.dart';

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
      backgroundColor: Colors.black,
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  physics: const TopClampedScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(16),
                                    padding: EdgeInsets.symmetric(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                          ),
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
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 16,
                            bottom: 110,
                          ),
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    user!.displayName ?? "",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "31",
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
                                        color: AppTheme.success,
                                        size: 14,
                                      ),
                                      Text(
                                        "Online now",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppTheme.success,
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
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 24),

                              user?.bio != null
                                  ? AboutMeSection(bio: user!.bio!)
                                  : SizedBox.shrink(),
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

class ActionBar extends StatelessWidget {
  const ActionBar({
    super.key,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 640 * 0.25,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.9),
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
                stops: [0, 0.2, 0.8],
              ),
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.white),
                  iconSize: 28,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.block_outlined, color: Colors.white),
                      iconSize: 28,
                    ),
                    IconButton(
                      onPressed: onToggleFavorite,
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite ? Colors.amber : Colors.white,
                      ),
                      iconSize: 28,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChatBottom extends StatelessWidget {
  const ChatBottom({super.key, this.isMe = false, required this.uid});

  final bool isMe;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Stack(
        children: [
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
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.5, 1],
                ),
              ),
            ),
          ),

          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 8,
                top: 20,
              ),
              child: isMe
                  ? SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.black,
                        ),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 4,
                              top: 4,
                              bottom: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Say something...',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.send),
                                  color: AppTheme.primary,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatPage(otherUserId: uid),
                              ),
                            );
                          },
                          icon: Icon(Icons.chat_bubble_outline_rounded),
                          color: AppTheme.primary,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Clamps overscroll at the top edge only, while preserving the default
/// (bouncy) iOS physics at the bottom.
class TopClampedScrollPhysics extends ScrollPhysics {
  const TopClampedScrollPhysics({super.parent});

  @override
  TopClampedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return TopClampedScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Clamp at the top — prevent scrolling above minScrollExtent.
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    // Let the parent handle the bottom edge (bouncy on iOS).
    return super.applyBoundaryConditions(position, value);
  }
}

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key, required this.bio});
  final String bio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          "About me".toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Text(bio, style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}
