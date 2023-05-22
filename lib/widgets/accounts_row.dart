
import 'package:budget_buddy/widgets/add_account_button.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/database/hive_db.dart';
import 'package:provider/provider.dart';

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
      height: MediaQuery.of(context).size.height / 3.8,
      child: database.accounts.isEmpty
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AddAccountButton(),
              ],
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                ...database.accounts.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AccountWidget(accountModel: e),
                    )),
                const AddAccountButton()
              ],
            ),
    );
  }
}
