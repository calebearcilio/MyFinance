import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/domain/models/category.dart';
import 'package:myfinance_app/domain/models/transaction.dart';
import 'package:myfinance_app/utils/date_formatter_extension.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Category category;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.category,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final valueFormate = NumberFormat.simpleCurrency().format(
      transaction.signedValue,
    );
    final themeContext = Theme.of(context);

    return Card(
      elevation: 5,
      child: ListTile(
        shape: themeContext.cardTheme.shape,
        onTap: onTap,
        onLongPress: onLongPress,
        leading: Card(
          color: category.color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              category.icon,
              color: Colors.white,
            ),
          ),
        ),

        title: Text(
          transaction.title,
          style: themeContext.textTheme.bodyLarge,
          maxLines: 1,
          overflow: .ellipsis,
        ),

        subtitle: Row(
          children: [
            Text(
              transaction.date.toFriendlyString(),
              style: themeContext.textTheme.bodySmall,
            ),
          ],
        ),

        trailing: Text(
          valueFormate,
          style: themeContext.textTheme.headlineSmall!.copyWith(
            color: transaction.type == TransactionType.expense
                ? themeContext.colorScheme.error
                : themeContext.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
