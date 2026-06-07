import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/core/models/transaction.dart';
import 'package:myfinance_app/core/utils/date_time_utils.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final valueFormate = NumberFormat.simpleCurrency().format(
      transaction.value,
    );
    final themeContext = Theme.of(context);

    return Card(
      elevation: 5,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        shape: themeContext.cardTheme.shape,
        leading: Card(
          color: transaction.category.color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              transaction.category.icon,
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
          style: themeContext.textTheme.titleMedium!.copyWith(
            color: transaction.type == TransactionType.expense
                ? Colors.red
                : Colors.green,
          ),
        ),
      ),
    );
  }
}
