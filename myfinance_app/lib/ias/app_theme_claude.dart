import 'package:flutter/material.dart';
import 'package:myfinance_app/ias/text_theme_claude.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MyFinance Color Tokens
// Paleta claro : #16A34A · #22C55E · #86EFAC · #E8F5EE · #1F2937 · #F3F4F6
// Paleta escuro: #16A34A · #22C55E · #059669 · #1F2937 · #374151 · #0F172A
// ─────────────────────────────────────────────────────────────────────────────

class AppColors {
  AppColors._();

  // ── Brand ────────────────────────────────────────────────────────────────
  static const green700   = Color(0xFF16A34A); // primary dark
  static const green500   = Color(0xFF22C55E); // primary
  static const green400   = Color(0xFF86EFAC); // primary light (claro)
  static const teal600    = Color(0xFF059669); // primary dark variant (escuro)
  static const greenTint  = Color(0xFFE8F5EE); // surface tint / light bg

  // ── Neutrals ─────────────────────────────────────────────────────────────
  static const slate800   = Color(0xFF1F2937); // text primary / dark surface
  static const slate700   = Color(0xFF374151); // dark card / mid-tone
  static const slate900   = Color(0xFF0F172A); // dark scaffold
  static const neutral100 = Color(0xFFF3F4F6); // light scaffold / surface

  // ── Semantic (compartilhados) ─────────────────────────────────────────────
  static const red500     = Color(0xFFEF4444);
  static const red100     = Color(0xFFFEE2E2);
  static const amber500   = Color(0xFFF59E0B);
  static const amber100   = Color(0xFFFEF3C7);
  static const blue500    = Color(0xFF3B82F6);
  static const blue100    = Color(0xFFDBEAFE);
  static const white      = Color(0xFFFFFFFF);
  static const black      = Color(0xFF000000);
}

// ─────────────────────────────────────────────────────────────────────────────
// ColorScheme — Tema Claro
// ─────────────────────────────────────────────────────────────────────────────

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // ── Primary ───────────────────────────────────────────────────────────────
  primary:            AppColors.green700,      // #16A34A — botões, FAB, ativo
  onPrimary:          AppColors.white,         // texto sobre primary
  primaryContainer:   AppColors.greenTint,     // #E8F5EE — chips, cards tintados
  onPrimaryContainer: AppColors.green700,      // texto sobre primaryContainer

  // ── Primary Fixed (M3) ───────────────────────────────────────────────────
  primaryFixed:           AppColors.green400,  // #86EFAC — hover / estado pressionado
  primaryFixedDim:        AppColors.green500,  // #22C55E — variante mais saturada
  onPrimaryFixed:         AppColors.slate800,
  onPrimaryFixedVariant:  AppColors.slate800,

  // ── Secondary ────────────────────────────────────────────────────────────
  secondary:            AppColors.green500,    // #22C55E — badges receita, destaques
  onSecondary:          AppColors.white,
  secondaryContainer:   AppColors.greenTint,
  onSecondaryContainer: AppColors.green700,

  // ── Tertiary (informativo / azul) ────────────────────────────────────────
  tertiary:            AppColors.blue500,
  onTertiary:          AppColors.white,
  tertiaryContainer:   AppColors.blue100,
  onTertiaryContainer: Color(0xFF1D4ED8),

  // ── Error (despesas / alertas) ────────────────────────────────────────────
  error:            AppColors.red500,
  onError:          AppColors.white,
  errorContainer:   AppColors.red100,
  onErrorContainer: Color(0xFFB91C1C),

  // ── Surface ───────────────────────────────────────────────────────────────
  surface:             AppColors.neutral100,   // #F3F4F6 — scaffold background
  onSurface:           AppColors.slate800,     // texto principal
  surfaceVariant:      AppColors.greenTint,    // #E8F5EE — cards / containers
  onSurfaceVariant:    Color(0xFF4B5563),      // texto secundário
  surfaceContainerLowest:  AppColors.white,
  surfaceContainerLow:     AppColors.neutral100,
  surfaceContainer:        AppColors.greenTint,
  surfaceContainerHigh:    AppColors.green400,
  surfaceContainerHighest: AppColors.green500,
  surfaceDim:          Color(0xFFD1FAE5),      // superfície escurecida sutil
  surfaceBright:       AppColors.white,        // cards, sheets

  // ── Background ────────────────────────────────────────────────────────────
  // (M3 unificou background→surface, mas mantemos para compatibilidade)
  scrim:               Color(0x52000000),      // overlay de modais
  shadow:              AppColors.black,

  // ── Outline ───────────────────────────────────────────────────────────────
  outline:             Color(0xFFD1D5DB),      // bordas de inputs e cards
  outlineVariant:      AppColors.greenTint,    // bordas suaves
  inverseSurface:      AppColors.slate800,
  onInverseSurface:    AppColors.neutral100,
  inversePrimary:      AppColors.green400,
);

// ─────────────────────────────────────────────────────────────────────────────
// ColorScheme — Tema Escuro
// ─────────────────────────────────────────────────────────────────────────────

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // ── Primary ───────────────────────────────────────────────────────────────
  primary:            AppColors.green500,      // #22C55E — botões e destaques
  onPrimary:          AppColors.slate900,      // texto escuro sobre verde brilhante
  primaryContainer:   AppColors.green700,      // #16A34A — containers primários
  onPrimaryContainer: AppColors.greenTint,     // texto claro sobre container verde

  // ── Primary Fixed ────────────────────────────────────────────────────────
  primaryFixed:           AppColors.green400,
  primaryFixedDim:        AppColors.teal600,   // #059669
  onPrimaryFixed:         AppColors.slate900,
  onPrimaryFixedVariant:  AppColors.greenTint,

  // ── Secondary ────────────────────────────────────────────────────────────
  secondary:            AppColors.teal600,     // #059669 — badges receita
  onSecondary:          AppColors.white,
  secondaryContainer:   AppColors.green700,    // #16A34A
  onSecondaryContainer: AppColors.green400,

  // ── Tertiary ─────────────────────────────────────────────────────────────
  tertiary:            AppColors.blue500,
  onTertiary:          AppColors.white,
  tertiaryContainer:   Color(0xFF1E3A5F),
  onTertiaryContainer: AppColors.blue100,

  // ── Error ─────────────────────────────────────────────────────────────────
  error:            Color(0xFFF87171),         // red-400 — melhor legibilidade no escuro
  onError:          AppColors.slate900,
  errorContainer:   Color(0xFF7F1D1D),
  onErrorContainer: AppColors.red100,

  // ── Surface ───────────────────────────────────────────────────────────────
  surface:             AppColors.slate900,     // #0F172A — scaffold background
  onSurface:           AppColors.neutral100,   // #F3F4F6 — texto principal
  surfaceVariant:      AppColors.slate800,     // #1F2937 — cards
  onSurfaceVariant:    Color(0xFF9CA3AF),      // texto secundário (gray-400)
  surfaceContainerLowest:  AppColors.black,
  surfaceContainerLow:     AppColors.slate900,
  surfaceContainer:        AppColors.slate800, // #1F2937
  surfaceContainerHigh:    AppColors.slate700, // #374151
  surfaceContainerHighest: Color(0xFF4B5563),
  surfaceDim:          AppColors.slate900,
  surfaceBright:       AppColors.slate700,     // #374151 — cards em destaque

  // ── Outros ────────────────────────────────────────────────────────────────
  scrim:               Color(0x80000000),
  shadow:              AppColors.black,
  outline:             AppColors.slate700,     // #374151 — bordas
  outlineVariant:      AppColors.slate800,     // bordas sutis
  inverseSurface:      AppColors.neutral100,
  onInverseSurface:    AppColors.slate800,
  inversePrimary:      AppColors.green700,
);

// ─────────────────────────────────────────────────────────────────────────────
// ThemeData completo — Claro e Escuro
// ─────────────────────────────────────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  // ── Helpers semânticos ────────────────────────────────────────────────────
  // Use estes atalhos nas telas em vez de acessar colorScheme diretamente.

  static Color income(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color expense(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color warning(BuildContext context) => AppColors.amber500;

  static Color cardColor(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainer;

  // ── Light Theme ───────────────────────────────────────────────────────────
  static ThemeData get light => _buildTheme(lightColorScheme);

  // ── Dark Theme ────────────────────────────────────────────────────────────
  static ThemeData get dark => _buildTheme(darkColorScheme);

  // ── Builder ───────────────────────────────────────────────────────────────
  static ThemeData _buildTheme(ColorScheme cs) {
    final isDark = cs.brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      brightness: cs.brightness,
      textTheme: isDark ? TextThemeClaude.dark : TextThemeClaude.light,

      // Scaffold
      scaffoldBackgroundColor: cs.surface,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor:    cs.surface,
        foregroundColor:    cs.onSurface,
        elevation:          0,
        scrolledUnderElevation: 0.5,
        shadowColor:        cs.shadow.withOpacity(0.08),
        titleTextStyle: TextStyle(
          fontSize:   18,
          fontWeight: FontWeight.w600,
          color:      cs.onSurface,
        ),
        iconTheme: IconThemeData(color: cs.onSurface),
      ),

      // Cards
      cardTheme: CardThemeData(
        color:     cs.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: cs.outline.withOpacity(0.5), width: 0.5),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:      cs.surface,
        selectedItemColor:    cs.primary,
        unselectedItemColor:  cs.onSurfaceVariant,
        type:      BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle:   const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
      ),

      // NavigationBar (M3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor:         cs.surface,
        indicatorColor:          cs.primaryContainer,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: cs.primary, size: 24);
          }
          return IconThemeData(color: cs.onSurfaceVariant, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, color: cs.primary);
          }
          return TextStyle(fontSize: 11, color: cs.onSurfaceVariant);
        }),
      ),

      // FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation:       2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation:   0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      // OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled:    true,
        fillColor: isDark ? cs.surfaceContainerLow : cs.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outline, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outline, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.error, width: 1.5),
        ),
        labelStyle:       TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
        hintStyle:        TextStyle(color: cs.onSurfaceVariant.withOpacity(0.5), fontSize: 14),
        floatingLabelStyle: TextStyle(color: cs.primary, fontSize: 12, fontWeight: FontWeight.w500),
        contentPadding:   const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIconColor:  cs.onSurfaceVariant,
        suffixIconColor:  cs.onSurfaceVariant,
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor:      cs.surfaceContainerLow,
        selectedColor:        cs.primaryContainer,
        labelStyle:           TextStyle(fontSize: 13, color: cs.onSurface),
        secondaryLabelStyle:  TextStyle(fontSize: 13, color: cs.onPrimaryContainer),
        side: BorderSide(color: cs.outline.withOpacity(0.5)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),

      // ProgressIndicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color:            cs.primary,
        linearTrackColor: cs.primaryContainer,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color:     cs.outline.withOpacity(0.4),
        thickness: 0.5,
        space:     0,
      ),

      // ListTile
      listTileTheme: ListTileThemeData(
        tileColor:       Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        titleTextStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: cs.onSurface),
        subtitleTextStyle: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
        iconColor:       cs.onSurfaceVariant,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? cs.surfaceContainerHigh : cs.inverseSurface,
        contentTextStyle: TextStyle(color: cs.onInverseSurface, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      // BottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor:    cs.surfaceContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        dragHandleColor: cs.onSurfaceVariant.withOpacity(0.4),
        showDragHandle:  true,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: cs.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: cs.onSurface),
        contentTextStyle: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected) ? cs.primary : cs.onSurfaceVariant),
        trackColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected)
                ? cs.primaryContainer
                : cs.surfaceContainerHigh),
      ),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected) ? cs.primary : Colors.transparent),
        checkColor: WidgetStateProperty.all(cs.onPrimary),
        side: BorderSide(color: cs.outline, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // IconButton
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: cs.onSurface,
          highlightColor:  cs.primary.withOpacity(0.1),
        ),
      ),

      // PopupMenu
      popupMenuTheme: PopupMenuThemeData(
        color:     cs.surfaceContainerHigh,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(fontSize: 14, color: cs.onSurface),
      ),
    );
  }
}