import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

class Income {
  final Transaction transaction;
  final Category category;
  Income(this.transaction, this.category);
  String get icon => category.iconString;
  DateTime get timestamp => transaction.timestamp;
}

class Expense {
  final Transaction transaction;
  final Category category;
  Expense(this.transaction, this.category);
  String get icon => category.iconString;
  DateTime get timestamp => transaction.timestamp;
}

enum TransactionTypes {
  expense,
  income;
}

class TransactionInfo {
  final TransactionTypes transactionType;
  final Transaction transcation;
  final Category category;
  TransactionInfo(this.transactionType, this.transcation, this.category);
  double get amount => transcation.amount;
  String get label => transcation.label;
  String get walletName => category.name;
  String get icon => category.iconString;
}
