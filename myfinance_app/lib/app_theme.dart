import 'package:flutter/material.dart';

class AppColors {
  // ── Brand ────────────────────────────────────────────────────────────────
  static const green700 = Color(0xFF16A34A); // primary dark
  static const green500 = Color(0xFF22C55E); // primary
  static const green400 = Color(0xFF86EFAC); // primary light (claro)
  static const teal600 = Color(0xFF059669); // primary dark variant (escuro)
  static const greenTint = Color(0xFFE8F5EE); // surface tint / light bg

  // ── Neutrals ─────────────────────────────────────────────────────────────
  static const slate800 = Color(0xFF1F2937); // text primary / dark surface
  static const slate700 = Color(0xFF374151); // dark card / mid-tone
  static const slate900 = Color(0xFF0F172A); // dark scaffold
  static const neutral100 = Color(0xFFF3F4F6); // light scaffold / surface

  // ── Semantic (compartilhados) ─────────────────────────────────────────────
  static const red500 = Color(0xFFEF4444);
  static const red100 = Color(0xFFFEE2E2);
  static const amber500 = Color(0xFFF59E0B);
  static const amber100 = Color(0xFFFEF3C7);
  static const blue500 = Color(0xFF3B82F6);
  static const blue100 = Color(0xFFDBEAFE);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.green700,
  onPrimary: AppColors.white,
  primaryContainer: AppColors.greenTint,
  onPrimaryContainer: AppColors.green700,
  primaryFixed: AppColors.green400,
  primaryFixedDim: AppColors.green500,
  onPrimaryFixed: AppColors.slate800,
  onPrimaryFixedVariant: AppColors.slate800,
  secondary: AppColors.green500,
  onSecondary: AppColors.white,
  secondaryContainer: AppColors.greenTint,
  onSecondaryContainer: AppColors.green700,
  tertiary: AppColors.blue500,
  onTertiary: AppColors.white,
  tertiaryContainer: AppColors.blue100,
  onTertiaryContainer: Color(0xFF1D4ED8),
  error: AppColors.red500,
  onError: AppColors.white,
  errorContainer: AppColors.red100,
  onErrorContainer: Color(0xFFB91C1C),
  surface: AppColors.neutral100,
  onSurface: AppColors.slate800,
  // surfaceVariant: AppColors.greenTint,
  onSurfaceVariant: Color(0xFF4B5563),
  surfaceContainerLowest: AppColors.white,
  surfaceContainerLow: AppColors.neutral100,
  surfaceContainer: AppColors.amber100,
  surfaceContainerHigh: AppColors.green400,
  surfaceContainerHighest: AppColors.green500,
  surfaceDim: Color(0xFFD1FAE5),
  surfaceBright: AppColors.white,
  scrim: Color(0x52000000),
  shadow: AppColors.black,
  outline: Color(0xFFD1D5DB),
  outlineVariant: AppColors.greenTint,
  inverseSurface: AppColors.slate800,
  onInverseSurface: AppColors.neutral100,
  inversePrimary: AppColors.green400,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.green500,
  onPrimary: AppColors.slate900,
  primaryContainer: AppColors.green700,
  onPrimaryContainer: AppColors.greenTint,
  primaryFixed: AppColors.green400,
  primaryFixedDim: AppColors.teal600,
  onPrimaryFixed: AppColors.slate900,
  onPrimaryFixedVariant: AppColors.greenTint,
  secondary: AppColors.teal600,
  onSecondary: AppColors.white,
  secondaryContainer: AppColors.green700,
  onSecondaryContainer: AppColors.green400,
  tertiary: AppColors.blue500,
  onTertiary: AppColors.white,
  tertiaryContainer: Color(0xFF1E3A5F),
  onTertiaryContainer: AppColors.blue100,
  error: Color(0xFFF87171),
  onError: AppColors.slate900,
  errorContainer: Color(0xFF7F1D1D),
  onErrorContainer: AppColors.red100,
  surface: AppColors.slate900,
  onSurface: AppColors.neutral100,
  // surfaceVariant: AppColors.slate800,
  onSurfaceVariant: Color(0xFF9CA3AF),
  surfaceContainerLowest: AppColors.black,
  surfaceContainerLow: AppColors.slate900,
  surfaceContainer: AppColors.slate800,
  surfaceContainerHigh: AppColors.slate700,
  surfaceContainerHighest: Color(0xFF4B5563),
  surfaceDim: AppColors.slate900,
  surfaceBright: AppColors.slate700,
  scrim: Color(0x80000000),
  shadow: AppColors.black,
  outline: AppColors.slate700,
  outlineVariant: AppColors.slate800,
  inverseSurface: AppColors.neutral100,
  onInverseSurface: AppColors.slate800,
  inversePrimary: AppColors.green700,
);

class AppTheme {
  static ThemeData get light =>
      _buildTheme(lightColorScheme, _buildTextTheme(AppColors.slate800));
  static ThemeData get dark =>
      _buildTheme(darkColorScheme, _buildTextTheme(AppColors.neutral100));

  /// borda circular padronizada, para ser usada em containers ou cards
  static BorderRadius get borderDefault => BorderRadius.circular(16);

  static TextTheme _buildTextTheme(Color colorBase) {
    const tabular = [FontFeature.tabularFigures()];
    const sans = "Inter";
    final subtle = colorBase.withAlpha(153);
    final muted = colorBase.withAlpha(102);

    return TextTheme(
      // ── Display ─────────────────────────────────────────────────────────
      // Usado em: tela de splash, saldo total (hero number)
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

      // ── Headline ─────────────────────────────────────────────────────────
      // Usado em: saldo do mês (dashboard hero), títulos de seção grande
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

      // ── Title ─────────────────────────────────────────────────────────────
      // Usado em: AppBar title, nome da transação, título de card
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
        height: 1.50,
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

      // ── Label ─────────────────────────────────────────────────────────────
      // Usado em: botões, chips, badges, labels de input, navegação
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

      // ── Body ──────────────────────────────────────────────────────────────
      // Usado em: descrição de transação, conteúdo de cards, listas
      bodyLarge: TextStyle(
        fontFamily: sans,
        fontSize: 16,
        height: 1.50,
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

  static ThemeData _buildTheme(ColorScheme cs, TextTheme textTheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      brightness: cs.brightness,
      scaffoldBackgroundColor: cs.surface,

      textTheme: textTheme,

      appBarTheme: AppBarTheme(
        data: AppBarThemeData(
          scrolledUnderElevation: 0,
          backgroundColor: cs.surface,
          foregroundColor: cs.onSurface,
        ),
      ),

      iconTheme: IconThemeData(color: cs.onPrimary),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cs.error,
        selectedItemColor: cs.primary,
        unselectedItemColor: cs.onSurfaceVariant,
      ),

      cardTheme: CardThemeData(
        color: cs.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderDefault,
          side: BorderSide(color: cs.outline.withAlpha(128), width: 0.5),
        ),
      ),
    );
  }
}
