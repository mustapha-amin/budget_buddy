import 'package:budget_buddy/constants/textStyles.dart';
import 'package:budget_buddy/models/account.dart';
import 'package:budget_buddy/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService extends ChangeNotifier {
  late Box<AccountModel> accountsBox;

  Future<void> initializeDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AccountModelAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    accountsBox = await Hive.openBox(boxName);
  }

  Future<void> createAccount(AccountModel accountModel) async {
    await accountsBox.add(accountModel);
    notifyListeners();
  }

  Future editAccount(int index, AccountModel accountModel) async {
    await accountsBox.putAt(index, accountModel);
    notifyListeners();
  }

  Future deleteAccount(int index) async {
    await accountsBox.deleteAt(index);
    notifyListeners();
  }

  List<AccountModel> get accounts => accountsBox.values.toList();

  void addTransaction(int acctIndex, TransactionModel transactionModel) {
    AccountModel? accountModel = accountsBox.getAt(acctIndex);
    accountModel!.transactions!.add(transactionModel);
    notifyListeners();
  }

  void deleteTransaction(int index) {
    AccountModel? accountModel = accountsBox.getAt(index);
    accountModel!.transactions!.removeAt(index);
    notifyListeners();
  }

  void clearTransactions() {
    accountsBox.values.map((e) => e.transactions!.clear());
    notifyListeners();
  }

  List<List<TransactionModel>?> get transactions =>
      accountsBox.values.map((e) => e.transactions).toList();

}
