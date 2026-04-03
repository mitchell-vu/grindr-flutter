import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                begin: .topCenter,
                end: .bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.9),
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
                stops: const [0, 0.2, 0.8],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const .symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, color: Colors.white),
                  iconSize: 28,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.block_outlined,
                        color: Colors.white,
                      ),
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
