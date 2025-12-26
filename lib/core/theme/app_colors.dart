import 'package:flutter/material.dart';

class AppColorScheme {
  final Color background;
  final Color surface;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color accent;
  final Color success;
  final Color warning;
  final Color danger;

  const AppColorScheme({
    required this.background,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.accent,
    required this.success,
    required this.warning,
    required this.danger,
  });
}

abstract class AppColors {
  static const light = AppColorScheme(
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF7F7F5),
    border: Color(0xFFE8E8E6),
    textPrimary: Color(0xFF191919),
    textSecondary: Color(0xFF6B6B6B),
    textTertiary: Color(0xFF9B9B9B),
    accent: Color(0xFF2383E2),
    success: Color(0xFF0F7B6C),
    warning: Color(0xFFC77D00),
    danger: Color(0xFFE03E3E),
  );

  static const dark = AppColorScheme(
    background: Color(0xFF191919),
    surface: Color(0xFF252525),
    border: Color(0xFF333333),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF9B9B9B),
    textTertiary: Color(0xFF6B6B6B),
    accent: Color(0xFF529CCA),
    success: Color(0xFF4DAB9A),
    warning: Color(0xFFDFAB4F),
    danger: Color(0xFFE06C6C),
  );

  static AppColorScheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }
}
