import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerLeft,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.ibmPlexSans(
          fontWeight: .bold,
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}
