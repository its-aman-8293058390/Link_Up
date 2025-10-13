import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6C63FF);
  static const secondary = Color(0xFF4A44B5);
  static const accent = Color(0xFFFF6584);
  static const backgroundLight = Color(0xFFF5F7FA);
  static const backgroundDark = Color(0xFF121212);
  static const cardLight = Colors.white;
  static const cardDark = Color(0xFF1E1E1E);
  static const textPrimaryLight = Colors.black87;
  static const textPrimaryDark = Colors.white70;
  static const textSecondaryLight = Colors.black54;
  static const textSecondaryDark = Colors.white60;
}

class AppStyles {
  static TextStyle heading1 = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle heading2 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle heading3 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 18,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 16,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 14,
  );

  static TextStyle caption = const TextStyle(
    fontSize: 12,
  );
}

class AppConstants {
  static const String appName = 'LinkUp';
  static const String mainChatId = 'main_chat';
}