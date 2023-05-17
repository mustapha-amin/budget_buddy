import 'dart:developer';

import 'package:budget_buddy/screens/add_account.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/database/hive_db.dart';
import 'package:provider/provider.dart';

import '../constants/utils.dart';
import 'account.dart';

class AccountsRow extends StatelessWidget {
  const AccountsRow({
    super.key,
    required this.hiveService,
  });

  final HiveService hiveService;

  @override
  Widget build(BuildContext context) {
    var database = Provider.of<HiveService>(context);
    return SizedBox(
      height: Utils(context).screenHeight / 3.5,
      child: database.accounts.isEmpty
          ? const SizedBox()
          : ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                ...database.accounts.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AccountWidget(accountModel: e),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.outlined(
                        onPressed: () {
                          log(database.transactions.length.toString());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AddAccount();
                          }));
                        },
                        icon: const Icon(Icons.add),
                      ),
                      const Text("Add account"),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
