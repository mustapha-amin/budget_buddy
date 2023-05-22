import 'package:budget_buddy/models/account.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AccountModel accountModel;
  AccountWidget({required this.accountModel});

  @override
  Widget build(BuildContext context) {
    IconData icon = switch (accountModel.iconID) {
      0 => Icons.money,
      1 => Icons.credit_card,
      2 => Icons.account_balance,
      3 => Icons.credit_card_sharp,
      _ => Icons.account_balance_wallet_outlined,
    };

    return Container(
      width: MediaQuery.of(context).size.width / 1.7,
      height: MediaQuery.of(context).size.height / 4,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              spreadRadius: 2.0,
              color: Colors.grey.withOpacity(0.2),
              blurStyle: BlurStyle.outer)
        ],
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.red[700]!,
              Colors.blue[700]!,
              Colors.green,
            ]),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 30,
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
