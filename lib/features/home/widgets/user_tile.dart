import 'package:flutter/material.dart';
import 'package:fluttr/configs/theme.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/features/profile/profile.dart';
import 'package:fluttr/shared/utils/page_transaction.dart';
import 'package:fluttr/shared/widgets/avatar.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(slideToTopPageTransaction(ProfilePage(uid: user.uid)));
      },
      child: ClipRRect(
        borderRadius: .circular(6),
        child: Stack(
          children: [
            Avatar(url: user.photoUrl, size: double.infinity, radius: 0),
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
                  Icon(Icons.circle, color: AppTheme.success, size: 12),
                  Text(
                    user.displayName ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
