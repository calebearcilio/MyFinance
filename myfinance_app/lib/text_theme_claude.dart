import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MyFinance — Text Theme
//
// Fonte principal : Inter (sans-serif, corpo e UI)
// Fonte numérica  : Inter — com fontFeatures tabular para valores monetários
//
// Para ativar as fontes, adicione ao pubspec.yaml:
//
//   flutter:
//     fonts:
//       - family: Inter
//         fonts:
//           - asset: assets/fonts/Inter-Regular.ttf
//           - asset: assets/fonts/Inter-Medium.ttf    weight: 500
//           - asset: assets/fonts/Inter-SemiBold.ttf  weight: 600
//           - asset: assets/fonts/Inter-Bold.ttf      weight: 700
//
// Ou via Google Fonts (sem assets locais):
//   dependencies:
//     google_fonts: ^6.2.1
//
//   TextThemeClaude.fromGoogleFonts() — veja método no final do arquivo.
// ─────────────────────────────────────────────────────────────────────────────

class TextThemeClaude {
  TextThemeClaude._();

  // ── Família base ──────────────────────────────────────────────────────────
  static const _sans = 'Inter';

  // ── Cor padrão por brilho (será sobrescrita pelo ColorScheme) ─────────────
  static const _darkText  = Color(0xFF1F2937); // slate-800
  static const _lightText = Color(0xFFF3F4F6); // neutral-100

  // ── Feature: números tabulares (alinhamento em colunas de valor) ──────────
  static const _tabular = [FontFeature.tabularFigures()];

  // ─────────────────────────────────────────────────────────────────────────
  // TextTheme — Claro
  // ─────────────────────────────────────────────────────────────────────────
  static TextTheme get light => _build(_darkText);

  // ─────────────────────────────────────────────────────────────────────────
  // TextTheme — Escuro
  // ─────────────────────────────────────────────────────────────────────────
  static TextTheme get dark => _build(_lightText);

  // ─────────────────────────────────────────────────────────────────────────
  // Builder interno
  // ─────────────────────────────────────────────────────────────────────────
  static TextTheme _build(Color base) {
    final subtle  = base.withOpacity(0.60); // texto secundário
    final muted   = base.withOpacity(0.40); // placeholder / label flutuante

    return TextTheme(
      // ── Display ─────────────────────────────────────────────────────────
      // Usado em: tela de splash, saldo total (hero number)
      displayLarge: TextStyle(
        fontFamily:  _sans,
        fontSize:    57,
        height:      1.12,
        fontWeight:  FontWeight.w700,
        letterSpacing: -0.25,
        color:       base,
        fontFeatures: _tabular,
      ),
      displayMedium: TextStyle(
        fontFamily:  _sans,
        fontSize:    45,
        height:      1.16,
        fontWeight:  FontWeight.w700,
        letterSpacing: -0.25,
        color:       base,
        fontFeatures: _tabular,
      ),
      displaySmall: TextStyle(
        fontFamily:  _sans,
        fontSize:    36,
        height:      1.22,
        fontWeight:  FontWeight.w700,
        letterSpacing: -0.25,
        color:       base,
        fontFeatures: _tabular,
      ),

      // ── Headline ─────────────────────────────────────────────────────────
      // Usado em: saldo do mês (dashboard hero), títulos de seção grande
      headlineLarge: TextStyle(
        fontFamily:  _sans,
        fontSize:    32,
        height:      1.25,
        fontWeight:  FontWeight.w700,
        letterSpacing: -0.5,
        color:       base,
        fontFeatures: _tabular,
      ),
      headlineMedium: TextStyle(
        fontFamily:  _sans,
        fontSize:    28,
        height:      1.29,
        fontWeight:  FontWeight.w600,
        letterSpacing: -0.25,
        color:       base,
      ),
      headlineSmall: TextStyle(
        fontFamily:  _sans,
        fontSize:    24,
        height:      1.33,
        fontWeight:  FontWeight.w600,
        letterSpacing: -0.25,
        color:       base,
      ),

      // ── Title ─────────────────────────────────────────────────────────────
      // Usado em: AppBar title, nome da transação, título de card
      titleLarge: TextStyle(
        fontFamily:  _sans,
        fontSize:    22,
        height:      1.27,
        fontWeight:  FontWeight.w600,
        letterSpacing: -0.25,
        color:       base,
      ),
      titleMedium: TextStyle(
        fontFamily:  _sans,
        fontSize:    16,
        height:      1.50,
        fontWeight:  FontWeight.w500,
        letterSpacing: 0.15,
        color:       base,
      ),
      titleSmall: TextStyle(
        fontFamily:  _sans,
        fontSize:    14,
        height:      1.43,
        fontWeight:  FontWeight.w500,
        letterSpacing: 0.1,
        color:       base,
      ),

      // ── Label ─────────────────────────────────────────────────────────────
      // Usado em: botões, chips, badges, labels de input, navegação
      labelLarge: TextStyle(
        fontFamily:  _sans,
        fontSize:    14,
        height:      1.43,
        fontWeight:  FontWeight.w600,
        letterSpacing: 0.1,
        color:       base,
      ),
      labelMedium: TextStyle(
        fontFamily:  _sans,
        fontSize:    12,
        height:      1.33,
        fontWeight:  FontWeight.w500,
        letterSpacing: 0.5,
        color:       subtle,
      ),
      labelSmall: TextStyle(
        fontFamily:  _sans,
        fontSize:    11,
        height:      1.45,
        fontWeight:  FontWeight.w500,
        letterSpacing: 0.5,
        color:       muted,
      ),

      // ── Body ──────────────────────────────────────────────────────────────
      // Usado em: descrição de transação, conteúdo de cards, listas
      bodyLarge: TextStyle(
        fontFamily:  _sans,
        fontSize:    16,
        height:      1.50,
        fontWeight:  FontWeight.w400,
        letterSpacing: 0.15,
        color:       base,
      ),
      bodyMedium: TextStyle(
        fontFamily:  _sans,
        fontSize:    14,
        height:      1.43,
        fontWeight:  FontWeight.w400,
        letterSpacing: 0.25,
        color:       base,
      ),
      bodySmall: TextStyle(
        fontFamily:  _sans,
        fontSize:    12,
        height:      1.33,
        fontWeight:  FontWeight.w400,
        letterSpacing: 0.4,
        color:       subtle,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Estilos semânticos extras (fora do TextTheme padrão do M3)
  // Use via TextThemeClaude.amount, TextThemeClaude.caption, etc.
  // ─────────────────────────────────────────────────────────────────────────

  /// Valor monetário principal — saldo hero, ex: "R$ 3.450,00"
  static TextStyle amount({
    double fontSize = 32,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
  }) =>
      TextStyle(
        fontFamily:   _sans,
        fontSize:     fontSize,
        height:       1.15,
        fontWeight:   fontWeight,
        letterSpacing: -0.5,
        color:        color,
        fontFeatures: _tabular,
      );

  /// Valor secundário — linha de transação, ex: "- R$ 125,00"
  static TextStyle amountSmall({Color? color}) => TextStyle(
        fontFamily:   _sans,
        fontSize:     15,
        height:       1.30,
        fontWeight:   FontWeight.w600,
        letterSpacing: -0.25,
        color:        color,
        fontFeatures: _tabular,
      );

  /// Porcentagem — ex: "78%" dentro de barra de orçamento
  static TextStyle percent({Color? color}) => TextStyle(
        fontFamily:   _sans,
        fontSize:     13,
        height:       1.30,
        fontWeight:   FontWeight.w700,
        letterSpacing: 0,
        color:        color,
        fontFeatures: _tabular,
      );

  /// Rótulo de categoria / data — texto auxiliar em cards de transação
  static const caption = TextStyle(
    fontFamily:   _sans,
    fontSize:     12,
    height:       1.33,
    fontWeight:   FontWeight.w400,
    letterSpacing: 0.4,
    color:        Color(0xFF6B7280), // gray-500 — neutro para ambos os temas
  );

  /// Overline — ex: "RECEITAS", "MÊS ATUAL" (texto em caixa alta)
  static const overline = TextStyle(
    fontFamily:   _sans,
    fontSize:     10,
    height:       1.60,
    fontWeight:   FontWeight.w600,
    letterSpacing: 1.5,
    color:        Color(0xFF9CA3AF), // gray-400
  );

  /// Texto de seção header — ex: "Últimas transações"
  static const sectionTitle = TextStyle(
    fontFamily:   _sans,
    fontSize:     16,
    height:       1.40,
    fontWeight:   FontWeight.w600,
    letterSpacing: -0.1,
  );

  /// Botão primário
  static const button = TextStyle(
    fontFamily:   _sans,
    fontSize:     15,
    height:       1.33,
    fontWeight:   FontWeight.w600,
    letterSpacing: 0.1,
  );
    
  static TextTheme fromGoogleFonts(Color base) {
    final raw  = _build(base);
    return GoogleFonts.interTextTheme(raw);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Google Fonts — alternativa sem assets locais
  // ─────────────────────────────────────────────────────────────────────────
  // Descomente e adicione google_fonts ao pubspec para usar:
  //
}