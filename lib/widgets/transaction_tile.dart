import 'package:budget_buddy/constants/utils.dart';
import 'package:budget_buddy/models/account.dart';
import 'package:budget_buddy/models/transaction.dart';
import 'package:budget_buddy/database/hive_db.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  TransactionModel transactionModel;
  TransactionTile({required this.transactionModel, super.key});

  @override
  Widget build(BuildContext context) {
    double amount = transactionModel.amount!;
    String char = transactionModel.isExpense! ? "-" : "+";
    HiveService hiveService = HiveService();
    AccountModel? account =
        hiveService.accountsBox.getAt(transactionModel.accountID!);
    String currency = account!.currency!;

    return Container(
      height: Utils(context).screenHeight / 9,
      width: Utils(context).screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: ListTile(
        title: Text(
          transactionModel.description!,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text(account.title!),
        trailing: Text(
          '$char $currency$amount',
          style: TextStyle(
            color: transactionModel.isExpense! ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}
