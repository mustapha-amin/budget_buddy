import 'package:budget_buddy/database/hive_db.dart';
import 'package:budget_buddy/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var database = Provider.of<HiveService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: database.transactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/no-transactions.png'),
                    width: MediaQuery.of(context).size.width / 0.2,
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  const Text(
                    "No transactions",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: database.transactions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      database.deleteTransaction(index);
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.delete),
                          Icon(Icons.delete),
                        ],
                      ),
                    ),
                    child: TransactionTile(
                      transactionModel: database.transactions[index],
                      isHistory: true,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
