import 'package:budget_buddy/constants/utils.dart';
import 'package:budget_buddy/models/account.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AccountModel accountModel;
  AccountWidget({required this.accountModel, super.key});

  @override
  Widget build(BuildContext context) {
    IconData icon = switch (accountModel.iconID) {
      1 => Icons.money,
      2 => Icons.credit_card,
      3 => Icons.account_balance,
      4 => Icons.credit_card_sharp,
      _ => Icons.account_balance_wallet_outlined,
    };

    return Container(
      width: Utils(context).screenWidth / 1.7,
      height: Utils(context).screenHeight / 4,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                accountModel.title!,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              Text(
                "${accountModel.currency} ${accountModel.amount}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
