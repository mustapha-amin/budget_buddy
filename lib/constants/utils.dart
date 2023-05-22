class InsufficientBalanceError implements Exception {
  const InsufficientBalanceError();
}


extension on String {
  String get title =>
      this[0].toUpperCase() + substring(1, length - 1).toLowerCase();
}

enum Account {
  manageAccounts,
  transactionHistory,
}

enum Transaction {
  expense,
  income,
}
