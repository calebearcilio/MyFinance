import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/features/common/components/contents.dart';
import 'package:myfinance_app/features/common/utils/date_time_utils.dart';

class TransactionDetails extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetails({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIncome = transaction.type == TransactionType.income;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      title: Text(
        isIncome ? "↑ Receita" : "↓ Despesa",
        textAlign: TextAlign.center,
        style: theme.textTheme.titleLarge?.copyWith(
          color: isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Valor e título
              Column(
                children: [
                  Text(
                    transaction.value.obterReal(),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction.title,
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Categoria
              DetailsSection(
                title: "Categoria",
                child: Row(
                  children: [
                    Card(
                      color: transaction.category.color,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          transaction.category.icon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        transaction.category.name,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Informações
              DetailsSection(
                title: "Informações",
                child: Column(
                  children: [
                    InfoRow(
                      label: "Data",
                      value: transaction.date.toFriendlyString(),
                    ),
                    InfoRow(
                      label: "Tipo",
                      value: isIncome ? "Receita" : "Despesa",
                    ),
                  ],
                ),
              ),

              if (transaction.description?.isNotEmpty ?? false) ...[
                const SizedBox(height: 12),

                // Descrição
                DetailsSection(
                  title: "Descrição",
                  child: Text(
                    transaction.description!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
