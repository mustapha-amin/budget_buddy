import 'package:budget_buddy/constants/textStyles.dart';
import 'package:budget_buddy/constants/utils.dart';
import 'package:budget_buddy/models/account.dart';
import 'package:budget_buddy/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService extends ChangeNotifier {
  static final HiveService _hiveService = HiveService._internal();

  factory HiveService() {
    return _hiveService;
  }

  HiveService._internal();

  late Box<AccountModel> accountsBox;
  late Box<TransactionModel> transactionsBox;

  Future<void> initializeDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AccountModelAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    accountsBox = await Hive.openBox(accountboxName);
    transactionsBox = await Hive.openBox(transactionBoxName);
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

  void addTransaction(TransactionModel transactionModel) {
    if ((transactionModel.isExpense! &&
            accounts[transactionModel.accountID!].amount! >=
                transactionModel.amount!) ||
        transactionModel.isExpense! == false) {
      transactionsBox.add(transactionModel);

      if (transactionModel.isExpense!) {
        accounts[transactionModel.accountID!].amount =
            accounts[transactionModel.accountID!].amount! -
                transactionModel.amount!;
      } else {
        accounts[transactionModel.accountID!].amount =
            accounts[transactionModel.accountID!].amount! +
                transactionModel.amount!;
      }
    } else {
      throw const InsufficientBalanceError();
    }
    notifyListeners();
  }

  void deleteTransaction(int index) {
    transactionsBox.deleteAt(index);
    notifyListeners();
  }

  void clearTransactions() {
    transactionsBox.clear();
    notifyListeners();
  }

  List<TransactionModel> get transactions => transactionsBox.values.toList();
}
