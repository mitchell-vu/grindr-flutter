import 'package:flutter/material.dart';
import 'package:grindr_flutter/features/chat/views/chat_history.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentPhotoIndex = 0;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const TopClampedScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 640,
                      child: Image.network(
                        'https://static.wikia.nocookie.net/marias/images/9/95/CINEMA.jpg/revision/latest/scale-to-width-down/1200?cb=20250708183259',
                        fit: BoxFit.cover,
                      ),
                    ),

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
                              Colors.black.withValues(alpha: 0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
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
                                color: Colors.black.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    );
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Icon(
                                      Icons.lock,
                                      size: 16,
                                      color: Colors.white.withValues(
                                        alpha: currentPhotoIndex == 3 ? 1 : 0.5,
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
                        Text(
                          "The Marías",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        Row(
                          spacing: 12,
                          children: [
                            Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 14,
                                ),
                                Text(
                                  "Online now",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
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

                        Column(
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
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Text(
                                "The Marías is an American alternative pop band from Los Angeles. They are known for performing songs in both English and Spanish in addition to infusing their music with elements including jazz percussion, guitar riffs, and horn solos.[1] Their core lineup consists of lead vocalist María Zardoya, drummer/producer Josh Conway, guitarist Jesse Perlman, and keyboardist Edward James.[2] The band has released two EPs and two studio albums, including Submarine (2024). They received their first solo Grammy nomination for Best New Artist[3] for the 68th Annual Grammy Awards in 2026.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
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

          ChatBottom(),
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
              iconSize: 28,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.block_outlined),
                  iconSize: 28,
                ),
                IconButton(
                  onPressed: onToggleFavorite,
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite
                        ? Colors.amber
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  iconSize: 28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBottom extends StatelessWidget {
  const ChatBottom({super.key});

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
              child: Row(
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
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatHistoryPage(title: "Mitchell Vu"),
                        ),
                      );
                    },
                    icon: Icon(Icons.chat_bubble_outline_rounded),
                    color: Theme.of(context).colorScheme.primary,
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
