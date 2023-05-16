import 'package:budget_buddy/constants/utils.dart';
import 'package:budget_buddy/models/account.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AccountModel accountModel;
  IconData? icon;
  AccountWidget({required this.accountModel, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utils(context).screenSize.width / 1.7,
      height: Utils(context).screenSize.height / 4,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.account_balance,
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
