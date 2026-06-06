import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension DateFormatter on DateTime {
  /// Formatar a data de forma amigável
  ///
  /// ex: Hoje, 13:23, Ontem, 14:49
  String toFriendlyString() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final current = DateTime(year, month, day);

    // Hoje, "Hoje, 17:31"
    if (current == today) {
      return DateFormat("'Hoje,' HH:mm").format(this);
    }

    // Ontem: "Ontem, 12:48"
    if (current == yesterday) {
      return DateFormat("'Ontem,' HH:mm").format(this);
    }

    // Mesmo ano: "27 maio"
    if (now.year == year) {
      return DateFormat("dd MMMM").format(this);
    }

    // Anos anteriores: 27/05/2024
    return DateFormat("dd'/'MM'/'yyyy").format(this);
  }
}

final dateTimeMask = MaskTextInputFormatter(
  mask: "##/##/#### ##:##",
  filter: {"#" : RegExp(r'[0-9]')},
  type: .lazy
);
