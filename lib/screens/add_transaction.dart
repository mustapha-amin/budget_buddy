import 'dart:developer';

import 'package:budget_buddy/constants/utils.dart';
import 'package:budget_buddy/models/account.dart';
import 'package:budget_buddy/models/transaction.dart';
import 'package:budget_buddy/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../database/hive_db.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Transaction transaction = Transaction.expense;
  AccountModel? _selectedAccount;
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    var database = Provider.of<HiveService>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text("New transaction"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                if (amountController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    _selectedAccount != null) {
                  try {
                    database.addTransaction(TransactionModel(
                      description: descriptionController.text,
                      isExpense: transaction == Transaction.expense,
                      amount: double.parse(amountController.text),
                      dateTime: DateTime.now(),
                      accountID: database.accounts.indexOf(_selectedAccount!),
                    ));
                    Navigator.pop(context);
                  } on InsufficientBalanceError {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Insufficient balance",
                        ),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  }
                }
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SegmentedButton<Transaction>(
                segments: const <ButtonSegment<Transaction>>[
                  ButtonSegment<Transaction>(
                    value: Transaction.expense,
                    label: Text('Expense'),
                    icon: Icon(
                      Icons.arrow_upward,
                      color: Colors.red,
                    ),
                  ),
                  ButtonSegment<Transaction>(
                    value: Transaction.income,
                    label: Text('Income'),
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.green,
                    ),
                  ),
                ],
                selected: <Transaction>{transaction},
                onSelectionChanged: (Set<Transaction> newSelection) {
                  setState(() {
                    transaction = newSelection.first;
                  });
                },
              ),
            ),
            VerticalSpacing(
              height: 40,
            ),
            _selectedAccount != null
                ? Text(
                    "Bal: ${_selectedAccount!.currency} ${_selectedAccount!.amount}")
                : const SizedBox(),
            VerticalSpacing(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey[600] as Color,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<AccountModel>(
                    hint: const Text("account"),
                    elevation: 0,
                    dropdownColor: Colors.grey[300],
                    value: _selectedAccount,
                    items: database.accounts
                        .map((e) => DropdownMenuItem<AccountModel>(
                              value: e,
                              child: Text(e.title!),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedAccount = val;
                      });
                    },
                  ),
                ),
              ),
            ),
            VerticalSpacing(
              height: 17,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
              child: TextField(
                controller: amountController,
                decoration: InputDecoration(
                  prefix: _selectedAccount != null
                      ? Text(_selectedAccount!.currency!)
                      : SizedBox(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: const Text("amount"),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            VerticalSpacing(
              height: 17,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: const Text("description"),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
