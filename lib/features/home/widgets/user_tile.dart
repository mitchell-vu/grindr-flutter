import 'package:flutter/material.dart';
import 'package:grindr_flutter/configs/constants.dart';
import 'package:grindr_flutter/configs/theme.dart';
import 'package:grindr_flutter/features/auth/models/user_model.dart';
import 'package:grindr_flutter/features/profile/profile.dart';
import 'package:grindr_flutter/shared/utils/page_transaction.dart';

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
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                user.photoUrl ?? avatarPlaceholderUrl,
                fit: BoxFit.cover,
              ),
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
                  Icon(Icons.circle, color: AppTheme.success, size: 12),
                  Text(
                    user.displayName ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
