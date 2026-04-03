import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttr/shared/widgets/coming_soon.dart';

class ViewsPage extends StatelessWidget {
  const ViewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: .only(left: 16, right: 16, top: 8, bottom: 16),
            child: Text(
              'Interest',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 24,
                fontWeight: .bold,
                color: Colors.white,
              ),
            ),
          ),
          ComingSoon(),
        ],
      ),
    );
  }
}
