import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          spacing: 4,
          mainAxisAlignment: .center,
          children: [
            Text(
              'Coming soon',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 24,
                fontWeight: .bold,
                color: Colors.white,
              ),
            ),
            Text(
              'This feature is not available yet',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 16,
                fontWeight: .w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
