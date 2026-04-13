import 'package:flutter/material.dart';
import 'package:fluttr/theme/color.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButtonTheme {
  static FilledButtonThemeData filledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.primary),
      foregroundColor: WidgetStatePropertyAll(Colors.black),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      splashFactory: NoSplash.splashFactory,
      enableFeedback: false,
    ),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFF1F1F20)),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      overlayColor: WidgetStatePropertyAll(
        Colors.black.withValues(alpha: 0.25),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      splashFactory: NoSplash.splashFactory,
      enableFeedback: false,
    ),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStatePropertyAll(Color(0xFF9E9EA9)),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      splashFactory: NoSplash.splashFactory,
      enableFeedback: false,
    ),
  );

  static IconButtonThemeData iconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
    ),
  );
}
