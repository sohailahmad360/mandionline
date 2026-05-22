import 'package:flutter/material.dart';

/// Mandi Online design tokens (forest green, off-white surfaces, accents).
abstract final class AppColors {
  static const Color primary = Color(0xFF007E33);
  static const Color primaryDark = Color(0xFF006329);
  static const Color onPrimary = Colors.white;
  static const Color screenBackground = Color(0xFFF9F9F9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF3F4F3);
  static const Color border = Color(0xFFE0E0E0);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color accentAmber = Color(0xFFFFC107);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color error = Color(0xFFB00020);
  static const Color ratingBg = Color(0xFFFFE082);
  static const Color chipInactive = Color(0xFFEEEEEE);
  static const Color sellingBadge = Color(0xFFE8F5E9);
  static const Color buyingBadge = Color(0xFFE3F2FD);
  static const Color pendingBg = Color(0xFFFFF3E0);
  static const Color chatIncoming = Color(0xFFFFFFFF);
  static const Color chatOutgoing = Color(0xFF007E33);
  static const Color inputFill = Color(0xFFF5F0E6);

  /// Drawer (nav list) — match product reference UI.
  static const Color drawerIconBg = Color(0xFFF5F3F0);
  static const Color drawerSelectedRow = Color(0xFFE9F3EE);
  static const Color drawerSelectedGreen = Color(0xFF146C34);
  static const Color badgeRed = Color(0xFFD92D20);
  static const Color logoutTintBg = Color(0xFFFFF5F5);
}
