import 'package:flutter/material.dart';
import 'package:fluttr/features/profile/views/edit_profile.dart';
import 'package:fluttr/features/chat/views/chat.dart';
import 'package:fluttr/theme/color.dart';

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
                  begin: .bottomCenter,
                  end: .topCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: const [0.5, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const .only(left: 20, right: 20, bottom: 8, top: 20),
              child: isMe
                  ? SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfilePage(),
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(fontWeight: .bold, fontSize: 16),
                        ),
                      ),
                    )
                  : Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const .only(
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
                                const Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Say something...',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send),
                                  color: AppColors.primary,
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
                                builder: (context) => ChatPage(otherUserId: uid),
                              ),
                            );
                          },
                          icon: const Icon(Icons.chat_bubble_outline_rounded),
                          color: AppColors.primary,
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
