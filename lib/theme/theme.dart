import 'package:flutter/material.dart';
import 'package:fluttr/theme/button.dart';
import 'package:fluttr/theme/color.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme(
      brightness: .dark,
      primary: AppColors.primary,
      onPrimary: Colors.black,
      secondary: AppColors.secondary,
      onSecondary: Colors.black,
      error: Color(0xFFEF5242),
      onError: Colors.white,
      surface: Colors.black,
      surfaceContainer: Colors.black,
      surfaceBright: Color(0xFF1F1F20),
      surfaceContainerHigh: Color(0xFF1F1F20),
      onSurface: Colors.white,
    ),

    textTheme: GoogleFonts.ibmPlexSansTextTheme(),

    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.ibmPlexSans(fontWeight: .w600, fontSize: 18),
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.black,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Color(0xFF1F1F20),
      selectedColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: .circular(24)),
      side: .none,
      showCheckmark: false,
      padding: .symmetric(horizontal: 8, vertical: 4),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xFFFFCC00),
      contentTextStyle: TextStyle(color: Colors.black),
      showCloseIcon: true,
    ),

    filledButtonTheme: AppButtonTheme.filledButtonTheme,
    elevatedButtonTheme: AppButtonTheme.elevatedButtonTheme,
    textButtonTheme: AppButtonTheme.textButtonTheme,
    iconButtonTheme: AppButtonTheme.iconButtonTheme,
  );
}
