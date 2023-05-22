import 'package:budget_buddy/constants/utils.dart';
import 'package:budget_buddy/models/account.dart';
import 'package:budget_buddy/models/transaction.dart';
import 'package:budget_buddy/database/hive_db.dart';
import 'package:flutter/material.dart';
import 'package:build_daemon/constants.dart';

extension on String {
  String get title =>
      this[0].toUpperCase() + substring(1, length).toLowerCase();
}

class TransactionTile extends StatelessWidget {
  TransactionModel transactionModel;
  bool? isHistory;
  TransactionTile({required this.transactionModel, this.isHistory = false});

  @override
  Widget build(BuildContext context) {
    double amount = transactionModel.amount!;
    String char = transactionModel.isExpense! ? "-" : "+";
    HiveService hiveService = HiveService();
    DateTime? dateTime = transactionModel.dateTime!;
    AccountModel? account =
        hiveService.accountsBox.getAt(transactionModel.accountID!);
    String currency = account!.currency!;

    return Container(
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: ListTile(
        title: Text(
          transactionModel.description!.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        subtitle: Text(account.title!),
        trailing: Column(
          mainAxisAlignment: isHistory!
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$char $currency$amount',
              style: TextStyle(
                color: transactionModel.isExpense! ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            isHistory!
                ? Text('${dateTime.day}/${dateTime.month}/${dateTime.year}')
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
