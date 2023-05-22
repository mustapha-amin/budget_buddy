import 'package:budget_buddy/database/hive_db.dart';
import 'package:budget_buddy/models/account.dart';
import 'package:budget_buddy/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  List<String> accountTypes = [
    "Cash",
    "Card",
    "Bank account",
    "Credit",
    "e-wallet"
  ];
  List<String> currencies = [
    "₦",
    "\$",
  ];
  String? _selectedAccountType;
  String? _selectedCurrency;

  @override
  Widget build(BuildContext context) {
    var database = Provider.of<HiveService>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add account"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: const Text("title"),
                ),
              ),
            ),
            VerticalSpacing(
              height: 20,
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
                  child: DropdownButton<String>(
                    hint: const Text("account type"),
                    elevation: 0,
                    dropdownColor: Colors.grey[300],
                    value: _selectedAccountType,
                    items: accountTypes
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedAccountType = val;
                      });
                    },
                  ),
                ),
              ),
            ),
            VerticalSpacing(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
              child: TextField(
                controller: _balanceController,
                decoration: InputDecoration(
                  suffix: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    width: _selectedCurrency != null
                        ? MediaQuery.of(context).size.width / 3.7
                        : MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text(" currency"),
                          elevation: 0,
                          dropdownColor: Colors.grey[300],
                          value: _selectedCurrency,
                          items: currencies
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedCurrency = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
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
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: _selectedAccountType != null &&
                        _balanceController.text.isNotEmpty &&
                        _titleController.text.isNotEmpty &&
                        _selectedCurrency != null
                    ? Colors.black
                    : Colors.grey,
                foregroundColor: _selectedAccountType != null &&
                        _balanceController.text.isNotEmpty &&
                        _titleController.text.isNotEmpty &&
                        _selectedCurrency != null
                    ? Colors.white
                    : Colors.grey[900],
              ),
              onPressed: () {
                _selectedAccountType != null &&
                        _balanceController.text.isNotEmpty &&
                        _titleController.text.isNotEmpty &&
                        _selectedCurrency != null
                    ? database
                        .createAccount(AccountModel(
                          title: _titleController.text,
                          type: _selectedAccountType,
                          currency: _selectedCurrency,
                          amount: double.parse(_balanceController.text),
                          iconID: accountTypes.indexOf(_selectedAccountType!),
                        ))
                        .whenComplete(() => Navigator.pop(context))
                    : null;
              },
              child: const Text("Add account"),
            )
          ],
        ),
      ),
    );
  }
}
