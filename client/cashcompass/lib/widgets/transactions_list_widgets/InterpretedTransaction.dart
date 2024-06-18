import 'package:flutter/cupertino.dart';

class InterpretedTransaction {
  String walletName;
  IconData categoryIcon;
  bool isExpense;
  IconData signIcon;

  InterpretedTransaction(
      {this.walletName = "not set",
      this.categoryIcon = CupertinoIcons.info,
      this.signIcon = CupertinoIcons.circle,
      this.isExpense = true});
}
