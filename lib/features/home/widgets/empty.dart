import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 4,
        mainAxisAlignment: .center,
        children: [
          Text(
            "No results",
            style: GoogleFonts.ibmPlexSans(
              fontSize: 32,
              fontWeight: .bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Try changing your filters",
            style: GoogleFonts.ibmPlexSans(
              fontSize: 16,
              fontWeight: .w600,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
