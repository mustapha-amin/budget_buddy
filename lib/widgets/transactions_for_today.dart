import 'package:budget_buddy/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import '../database/hive_db.dart';

class TransactionsForToday extends StatelessWidget {
  const TransactionsForToday({
    super.key,
    required this.database,
  });

  final HiveService database;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: database.transactionsForToday.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: TransactionTile(
              transactionModel: database.transactionsForToday[index],
            ),
          );
        },
      ),
    );
  }
}