import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key, required this.bio});
  final String bio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(
          "About me".toUpperCase(),
          style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: .bold),
        ),
        Container(
          padding: const .all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: const BorderRadius.only(
              topLeft: .circular(16),
              topRight: .circular(16),
              bottomRight: .circular(16),
            ),
          ),
          child: Text(bio, style: const TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}
