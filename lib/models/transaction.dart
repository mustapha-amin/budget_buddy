class TransactionModel {
  int? id;
  bool? isExpense;
  double? amount;
  DateTime? dateTime;

  TransactionModel({
    this.id,
    this.isExpense = true,
    this.amount,
    this.dateTime,
  });
}
