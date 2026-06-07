import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  static TextTheme get light => _build(AppColors.slate800);
  static TextTheme get dark => _build(AppColors.neutral100);

  static TextTheme _build(Color colorBase) {
    const tabular = [FontFeature.tabularFigures()];
    const sans = 'Inter';
    final subtle = colorBase.withAlpha(153);
    final muted = colorBase.withAlpha(102);

    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: sans,
        fontSize: 57,
        height: 1.12,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: colorBase,
        fontFeatures: tabular,
      ),
      displayMedium: TextStyle(
        fontFamily: sans,
        fontSize: 45,
        height: 1.16,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: colorBase,
        fontFeatures: tabular,
      ),
      displaySmall: TextStyle(
        fontFamily: sans,
        fontSize: 36,
        height: 1.22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: colorBase,
        fontFeatures: tabular,
      ),
      headlineLarge: TextStyle(
        fontFamily: sans,
        fontSize: 32,
        height: 1.25,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: colorBase,
        fontFeatures: tabular,
      ),
      headlineMedium: TextStyle(
        fontFamily: sans,
        fontSize: 28,
        height: 1.29,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
        color: colorBase,
      ),
      headlineSmall: TextStyle(
        fontFamily: sans,
        fontSize: 24,
        height: 1.33,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
        color: colorBase,
      ),
      titleLarge: TextStyle(
        fontFamily: sans,
        fontSize: 22,
        height: 1.27,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
        color: colorBase,
      ),
      titleMedium: TextStyle(
        fontFamily: sans,
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: colorBase,
      ),
      titleSmall: TextStyle(
        fontFamily: sans,
        fontSize: 14,
        height: 1.43,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: colorBase,
      ),
      labelLarge: TextStyle(
        fontFamily: sans,
        fontSize: 14,
        height: 1.43,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: colorBase,
      ),
      labelMedium: TextStyle(
        fontFamily: sans,
        fontSize: 12,
        height: 1.33,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: subtle,
      ),
      labelSmall: TextStyle(
        fontFamily: sans,
        fontSize: 11,
        height: 1.45,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: muted,
      ),
      bodyLarge: TextStyle(
        fontFamily: sans,
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: colorBase,
      ),
      bodyMedium: TextStyle(
        fontFamily: sans,
        fontSize: 14,
        height: 1.43,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: colorBase,
      ),
      bodySmall: TextStyle(
        fontFamily: sans,
        fontSize: 12,
        height: 1.33,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: subtle,
      ),
    );
  }
}
