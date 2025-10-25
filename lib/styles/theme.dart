import 'package:flutter/material.dart';

// Color palette - easy to customize
class AppColors {
  // Primary neon purple - change these hex values to customize
  static const Color neonPurple = Color(0xFF9D4EDD);
  static const Color neonPurpleLight = Color(0xFFC77DFF);
  static const Color neonPurpleDark = Color(0xFF7B2CBF);
  
  // Secondary lime green - change these hex values to customize
  static const Color limeGreen = Color(0xFFCDFF00);
  static const Color limeGreenDark = Color(0xFFABD900);
  
  // Background colors
  static const Color background = Color(0xFF0A0A0A);
  static const Color cardBackground = Color(0xFF1A1A1A);
  
  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  
  // Glow effects
  static const BoxShadow neonGlowPurple = BoxShadow(
    color: Color(0x55C77DFF),
    blurRadius: 20,
    spreadRadius: 2,
  );
  
  static const BoxShadow neonGlowLime = BoxShadow(
    color: Color(0x55CDFF00),
    blurRadius: 20,
    spreadRadius: 2,
  );
}

// Animation constants - tune these for different speeds
class AnimationConstants {
  // Page entrance animation duration
  static const Duration pageEnterDuration = Duration(milliseconds: 1500);
  
  // Hero tile hover response time
  static const Duration tileHoverDuration = Duration(milliseconds: 200);
  
  // Scroll reveal animation duration
  static const Duration scrollRevealDuration = Duration(milliseconds: 800);
  
  // Auto-scroll speed (time to complete one loop)
  static const Duration autoScrollSpeed = Duration(seconds: 20);
  
  // Default animation curves
  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
}