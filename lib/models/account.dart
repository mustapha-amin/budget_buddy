import 'package:budget_buddy/models/transaction.dart';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class AccountModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? currency;

  @HiveField(4)
  double? amount;

  @HiveField(5)
  int? iconID;

  @HiveField(6)
  List<TransactionModel>? transactions;

  AccountModel({
    this.id,
    this.title,
    this.type,
    this.currency,
    this.amount,
    this.iconID,
    this.transactions,
  });
}
