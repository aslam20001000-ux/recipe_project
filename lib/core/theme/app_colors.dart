import 'package:flutter/material.dart';

/// Color palette taken from the Figma design (dark theme).
abstract final class AppColors {
  static const background = Color(0xFF111318);
  static const surface = Color(0xFF1B1E25);
  static const surfaceHigh = Color(0xFF252932);
  static const border = Color(0xFF2E333D);

  static const primary = Color(0xFFE07B2A);
  static const onPrimary = Colors.white;

  static const textPrimary = Color(0xFFF4F4F6);
  static const textSecondary = Color(0xFF9AA0AA);
  static const textMuted = Color(0xFF6B717C);

  static const success = Color(0xFF3FB67F);
  static const warning = Color(0xFFF2B33D);
  static const danger = Color(0xFFE5484D);

  static const plant = success;
  static const meat = danger;
  static const favorite = danger;
  static const accentTeal = Color(0xFF2EB8A0);
  static const blob = Color(0xFF1F3A44);
}
