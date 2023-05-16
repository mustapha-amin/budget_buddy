import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  bool? isExpense;

  @HiveField(2)
  double? amount;

  @HiveField(3)
  DateTime? dateTime;

  TransactionModel({
    this.id,
    this.isExpense = true,
    this.amount,
    this.dateTime,
  });
}
