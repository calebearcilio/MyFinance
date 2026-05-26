import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final valueFormate = NumberFormat.simpleCurrency().format(
      transaction.value,
    );
    final dateFormate = DateFormat.yMMMEd().format(transaction.date);
    final themeContext = Theme.of(context);

    return Card(
      elevation: 5,
      child: ListTile(
        leading: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: themeContext.colorScheme.tertiary,
              width: 2,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: FittedBox(
            child: Text(
              valueFormate,
              style: themeContext.textTheme.titleSmall,
            ),
          ),
        ),

        title: Text(
          transaction.title,
          style: themeContext.textTheme.bodyLarge,
        ),

        subtitle: Text(
          dateFormate,
          style: themeContext.textTheme.bodySmall,
        ),
        
        trailing: IconButton(
          onPressed: null,
          icon: Icon(
            Icons.delete,
            color: themeContext.colorScheme.error,
          ),
        ),
      ),
    );
  }
}
