// ============================================================
// main.dart - Entry point Flutter
// ------------------------------------------------------------
// MyGary LightNovel (QuestNode engine)
// Tema: kertas krem, paperclip emas, font serif coklat.
// ============================================================

import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyGaryApp());
}

class MyGaryApp extends StatelessWidget {
  const MyGaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyGary LightNovel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}