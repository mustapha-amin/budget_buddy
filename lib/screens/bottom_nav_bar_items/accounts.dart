import 'package:budget_buddy/constants/utils.dart';
import 'package:budget_buddy/database/hive_db.dart';
import 'package:budget_buddy/screens/transaction_history.dart';
import 'package:budget_buddy/widgets/accounts_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  Account account = Account.manageAccounts;
  @override
  Widget build(BuildContext context) {
    var database = Provider.of<HiveService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          SegmentedButton<Account>(
            segments: const <ButtonSegment<Account>>[
              ButtonSegment<Account>(
                value: Account.manageAccounts,
                label: Text('Manage accounts'),
                icon: Icon(Icons.wallet),
              ),
              ButtonSegment<Account>(
                value: Account.transactionHistory,
                label: Text('Transaction history'),
                icon: Icon(Icons.history),
              ),
            ],
            selected: <Account>{account},
            onSelectionChanged: (Set<Account> newSelection) {
              setState(() {
                account = newSelection.first;
              });
            },
          ),
          Expanded(
            child: account == Account.manageAccounts
                ? database.accounts.isEmpty
                    ? const Center(
                        child: Text("No account"),
                      )
                    : const AccountsList()
                : const TransactionHistory(),
          )
        ],
      ),
    );
  }
}
