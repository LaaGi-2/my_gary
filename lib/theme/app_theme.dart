// ============================================================
// theme/app_theme.dart
// ------------------------------------------------------------
// Tema visual \"MyGary LightNovel\" - kertas krem bergaya buku
// interaktif (light novel). Warna serif coklat tua, aksen emas,
// background krem dengan tekstur kertas.
// ============================================================

import 'package:flutter/material.dart';

class AppTheme {
  // Palet warna kertas krem
  static const Color paperCream = Color(0xFFF5EFE0);      // background utama
  static const Color paperLight = Color(0xFFFAF6EB);      // panel terang
  static const Color paperShadow = Color(0xFFE8DFC9);     // bayangan kertas
  static const Color inkBrown = Color(0xFF4A3520);        // teks utama
  static const Color inkSoft = Color(0xFF7A6A55);         // teks sekunder
  static const Color goldClip = Color(0xFFE8B84A);        // paperclip emas
  static const Color goldClipDark = Color(0xFFB8881A);    // bayangan emas
  static const Color accentRed = Color(0xFF8B3A2A);       // aksen ending tragis
  static const Color accentGreen = Color(0xFF4A6B3A);     // aksen ending idealis

  // Spacing (8pt grid)
  static const double sp1 = 8;
  static const double sp2 = 16;
  static const double sp3 = 24;
  static const double sp4 = 32;

  // Radius
  static const double rSm = 8;
  static const double rMd = 14;
  static const double rLg = 22;

  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: paperCream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: inkBrown,
      primary: inkBrown,
      secondary: goldClip,
      background: paperCream,
      surface: paperLight,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'serif',
        fontWeight: FontWeight.bold,
        fontSize: 48,
        color: inkBrown,
        letterSpacing: 0.5,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'serif',
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: inkBrown,
      ),
      titleLarge: TextStyle(
        fontFamily: 'serif',
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: inkBrown,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'serif',
        fontSize: 16,
        height: 1.55,
        color: inkBrown,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'serif',
        fontSize: 14,
        height: 1.45,
        color: inkSoft,
      ),
      labelLarge: TextStyle(
        fontFamily: 'serif',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: inkBrown,
      ),
    ),
  );
}