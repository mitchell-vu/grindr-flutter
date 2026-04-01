import 'package:flutter/material.dart';
import 'package:fluttr/theme/color.dart';
import 'package:google_fonts/google_fonts.dart';

class NoResult extends StatelessWidget {
  const NoResult({
    super.key,
    this.title = "No results",
    this.subtitle = "Try changing your filters",
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 4,
        mainAxisAlignment: .center,
        children: [
          Text(
            title,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 32,
              fontWeight: .bold,
              color: Colors.white,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 16,
              fontWeight: .w600,
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Reset Filter",
              style: GoogleFonts.ibmPlexSans(
                fontSize: 16,
                fontWeight: .w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
