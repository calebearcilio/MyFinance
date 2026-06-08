class Finance {
  final double expense;
  final double income;

  Finance({
    required this.expense,
    required this.income,
  });

  double get balance => income - expense;
}
