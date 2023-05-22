import 'package:budget_buddy/database/hive_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';

class AccountsList extends StatefulWidget {
  const AccountsList({super.key});

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    var database = Provider.of<HiveService>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: ListView.builder(
        itemCount: database.accounts.length,
        itemBuilder: (context, index) {
          AccountModel account = database.accounts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
            child: Dismissible(
              key: UniqueKey(),
              resizeDuration: const Duration(milliseconds: 100),
              onDismissed: (direction) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete Account"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            database.deleteAccount(index);
                          },
                          child: const Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: const Text("No"),
                        ),
                      ],
                    );
                  },
                );
              },
              background: Container(
                padding: const EdgeInsets.all(6),
                color: Colors.red,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.delete_forever),
                  ],
                ),
              ),
              secondaryBackground: Container(
                padding: const EdgeInsets.all(6),
                color: Colors.red,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.delete_forever),
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: ListTile(
                  leading: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: switch (account.iconID) {
                      0 => const Icon(Icons.money),
                      1 => const Icon(Icons.credit_card),
                      2 => const Icon(Icons.account_balance),
                      3 => const Icon(Icons.credit_card_sharp),
                      _ => const Icon(Icons.account_balance_wallet_outlined),
                    },
                  ),
                  title: Text(account.title!),
                  trailing: Text('${account.currency} ${account.amount}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
