import 'package:budget_buddy/models/transaction.dart';
import 'package:flutter/widgets.dart';

class AccountModel {
  String? title;
  String? type;
  String? currency;
  double? amount;
  int? iconID;
  List<TransactionModel>? transactions;

  AccountModel({
    this.title,
    this.type,
    this.currency,
    this.amount,
    this.iconID,
    this.transactions,
  });
}
