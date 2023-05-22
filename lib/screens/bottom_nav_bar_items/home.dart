import 'package:budget_buddy/screens/add_transaction.dart';
import 'package:budget_buddy/database/hive_db.dart';
import 'package:budget_buddy/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/accounts_row.dart';
import '../../widgets/transactions_for_today.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var database = Provider.of<HiveService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            AccountsRow(hiveService: database),
            VerticalSpacing(
              height: 30,
            ),
            database.transactionsForToday.isEmpty
                ? const SizedBox()
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Transactions for today",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            database.transactionsForToday.isEmpty
                ? const Center(
                    child: Text("No transaction today"),
                  )
                : TransactionsForToday(database: database),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          database.accounts.isEmpty
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Add an account"),
                    duration: Duration(milliseconds: 500),
                  ),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const AddTransaction();
                  }),
                );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
