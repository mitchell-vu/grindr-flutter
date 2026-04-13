import 'package:flutter/material.dart';

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
          'About me'.toUpperCase(),
          style: const TextStyle(
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Text(
            bio,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
