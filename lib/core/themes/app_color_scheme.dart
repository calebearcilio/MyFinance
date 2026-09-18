import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppColorScheme {
  static const light = ColorScheme(
    brightness: Brightness.light,

    // ========================= PRIMARY
    primary: AppColors.primaryLight,
    onPrimary: AppColors.white,

    primaryContainer: AppColors.green100,
    onPrimaryContainer: AppColors.green600,

    primaryFixed: AppColors.green200,
    primaryFixedDim: AppColors.green400,
    onPrimaryFixed: AppColors.slate800,
    onPrimaryFixedVariant: AppColors.slate500,

    // ========================= SECONDARY
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,

    secondaryContainer: AppColors.green100,
    onSecondaryContainer: AppColors.green600,

    // ========================= TERTIARY
    tertiary: AppColors.accent,
    onTertiary: AppColors.white,

    tertiaryContainer: AppColors.green100,
    onTertiaryContainer: AppColors.teal800,

    // ========================= ERROR
    error: AppColors.red500,
    onError: AppColors.white,

    errorContainer: AppColors.red100,
    onErrorContainer: Color(0xFF991B1B),

    // ========================= SURFACE
    surface: AppColors.surfaceLight,
    onSurface: AppColors.slate800,

    onSurfaceVariant: AppColors.gray600,

    surfaceContainerLowest: AppColors.white,
    surfaceContainerLow: AppColors.neutral100,
    surfaceContainer: AppColors.neutral300,
    surfaceContainerHigh: AppColors.neutral300,
    surfaceContainerHighest: AppColors.gray500,

    surfaceDim: AppColors.neutral200,
    surfaceBright: AppColors.white,

    // ========================= OTHERS
    outline: AppColors.neutral300,
    outlineVariant: AppColors.green100,

    shadow: AppColors.black,
    scrim: Color(0x52000000),

    inverseSurface: AppColors.slate800,
    onInverseSurface: AppColors.white,
    inversePrimary: AppColors.primaryDark,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,

    // ========================= PRIMARY
    primary: AppColors.primaryDark,
    onPrimary: AppColors.slate900,

    primaryContainer: AppColors.green700,
    onPrimaryContainer: AppColors.green100,

    primaryFixed: AppColors.green400,
    primaryFixedDim: AppColors.green600,
    onPrimaryFixed: AppColors.slate900,
    onPrimaryFixedVariant: AppColors.green100,

    // ========================= SECONDARY
    secondary: AppColors.accent,
    onSecondary: AppColors.white,

    secondaryContainer: AppColors.teal800,
    onSecondaryContainer: AppColors.green100,

    // ========================= TERTIARY
    tertiary: AppColors.green400,
    onTertiary: AppColors.slate900,

    tertiaryContainer: AppColors.teal900,
    onTertiaryContainer: AppColors.green100,

    // ========================= ERROR
    error: AppColors.red500,
    onError: AppColors.slate900,

    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: AppColors.red100,

    // ========================= SURFACE
    surface: AppColors.surfaceDark,
    onSurface: AppColors.white,

    onSurfaceVariant: Color(0xFF9CA3AF),

    surfaceContainerLowest: AppColors.black,
    surfaceContainerLow: AppColors.surfaceDark,
    surfaceContainer: AppColors.cardDark,
    surfaceContainerHigh: AppColors.slate700,
    surfaceContainerHighest: AppColors.slate500,

    surfaceDim: AppColors.surfaceDark,
    surfaceBright: AppColors.cardDark,

    // ========================= OTHERS
    outline: AppColors.slate700,
    outlineVariant: AppColors.slate800,

    shadow: AppColors.black,
    scrim: Color(0x80000000),

    inverseSurface: AppColors.neutral100,
    onInverseSurface: AppColors.slate800,
    inversePrimary: AppColors.primaryLight,
  );
}

class AppColorSchemeIA {
  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: AppColorsIA.green700,
    onPrimary: AppColorsIA.white,
    primaryContainer: AppColorsIA.greenTint,
    onPrimaryContainer: AppColorsIA.green700,
    primaryFixed: AppColorsIA.green400,
    primaryFixedDim: AppColorsIA.green500,
    onPrimaryFixed: AppColorsIA.slate800,
    onPrimaryFixedVariant: AppColorsIA.slate800,
    secondary: AppColorsIA.green500,
    onSecondary: AppColorsIA.white,
    secondaryContainer: AppColorsIA.greenTint,
    onSecondaryContainer: AppColorsIA.green700,
    tertiary: AppColorsIA.blue500,
    onTertiary: AppColorsIA.white,
    tertiaryContainer: AppColorsIA.blue100,
    onTertiaryContainer: Color(0xFF1D4ED8),
    error: AppColorsIA.red500,
    onError: AppColorsIA.white,
    errorContainer: AppColorsIA.red100,
    onErrorContainer: Color(0xFFB91C1C),
    surface: AppColorsIA.neutral100,
    onSurface: AppColorsIA.slate800,
    onSurfaceVariant: Color(0xFF4B5563),
    surfaceContainerLowest: AppColorsIA.white,
    surfaceContainerLow: AppColorsIA.neutral100,
    surfaceContainer: AppColorsIA.amber100,
    surfaceContainerHigh: AppColorsIA.green400,
    surfaceContainerHighest: AppColorsIA.green500,
    surfaceDim: Color(0xFFD1FAE5),
    surfaceBright: AppColorsIA.white,
    scrim: Color(0x52000000),
    shadow: AppColorsIA.black,
    outline: Color(0xFFD1D5DB),
    outlineVariant: AppColorsIA.greenTint,
    inverseSurface: AppColorsIA.slate800,
    onInverseSurface: AppColorsIA.neutral100,
    inversePrimary: AppColorsIA.green400,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColorsIA.green500,
    onPrimary: AppColorsIA.slate900,
    primaryContainer: AppColorsIA.green700,
    onPrimaryContainer: AppColorsIA.greenTint,
    primaryFixed: AppColorsIA.green400,
    primaryFixedDim: AppColorsIA.teal600,
    onPrimaryFixed: AppColorsIA.slate900,
    onPrimaryFixedVariant: AppColorsIA.greenTint,
    secondary: AppColorsIA.teal600,
    onSecondary: AppColorsIA.white,
    secondaryContainer: AppColorsIA.green700,
    onSecondaryContainer: AppColorsIA.green400,
    tertiary: AppColorsIA.blue500,
    onTertiary: AppColorsIA.white,
    tertiaryContainer: Color(0xFF1E3A5F),
    onTertiaryContainer: AppColorsIA.blue100,
    error: AppColorsIA.red500,
    onError: AppColorsIA.slate900,
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: AppColorsIA.red100,
    surface: AppColorsIA.slate900,
    onSurface: AppColorsIA.neutral100,
    onSurfaceVariant: Color(0xFF9CA3AF),
    surfaceContainerLowest: AppColorsIA.black,
    surfaceContainerLow: AppColorsIA.slate900,
    surfaceContainer: AppColorsIA.slate800,
    surfaceContainerHigh: AppColorsIA.slate700,
    surfaceContainerHighest: Color(0xFF4B5563),
    surfaceDim: AppColorsIA.slate900,
    surfaceBright: AppColorsIA.slate700,
    scrim: Color(0x80000000),
    shadow: AppColorsIA.black,
    outline: AppColorsIA.slate700,
    outlineVariant: AppColorsIA.slate800,
    inverseSurface: AppColorsIA.neutral100,
    onInverseSurface: AppColorsIA.slate800,
    inversePrimary: AppColorsIA.green700,
  );
}
