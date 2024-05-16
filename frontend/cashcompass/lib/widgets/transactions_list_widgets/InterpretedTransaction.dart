import 'package:flutter/cupertino.dart';

class InterpretedTransaction {
  String walletName;
  IconData categoryIcon;
  IconData signIcon;

  InterpretedTransaction(
      {this.walletName = "not set",
      this.categoryIcon = CupertinoIcons.info,
      this.signIcon = CupertinoIcons.circle});
}
