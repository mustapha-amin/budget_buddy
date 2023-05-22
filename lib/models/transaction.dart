import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  String? description;

  @HiveField(1)
  bool? isExpense;

  @HiveField(2)
  double? amount;

  @HiveField(3)
  DateTime? dateTime;

  @HiveField(4)
  int? accountID;

  TransactionModel({
    this.description,
    this.isExpense = true,
    this.amount,
    this.dateTime,
    this.accountID,
  });
}