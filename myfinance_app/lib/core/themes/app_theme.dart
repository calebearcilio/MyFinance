import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData get light =>
      _buildTheme(AppColorScheme.light, AppTextTheme.light);
  static ThemeData get dark =>
      _buildTheme(AppColorScheme.dark, AppTextTheme.dark);

  static BorderRadius get borderDefault => BorderRadius.circular(16);

  static ThemeData _buildTheme(ColorScheme cs, TextTheme textTheme) {
    final isDark = cs.brightness == Brightness.dark;
    final inputBorder = BorderRadius.circular(12);

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

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? cs.surfaceContainerLow : cs.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: inputBorder,
          borderSide: BorderSide(color: cs.outline, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: inputBorder,
          borderSide: BorderSide(color: cs.outline, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: inputBorder,
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: inputBorder,
          borderSide: BorderSide(color: cs.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: inputBorder,
          borderSide: BorderSide(color: cs.error, width: 1.5),
        ),
        labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
        hintStyle: TextStyle(
          color: cs.onSurfaceVariant.withAlpha(128),
          fontSize: 14,
        ),
        floatingLabelStyle: TextStyle(
          color: cs.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        prefixIconColor: cs.onSurfaceVariant,
        suffixIconColor: cs.onSurfaceVariant,
      ),
    );
  }
}
