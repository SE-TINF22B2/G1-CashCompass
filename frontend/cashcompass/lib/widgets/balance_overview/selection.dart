import 'package:flutter/cupertino.dart';

enum Selection {
  income(CupertinoColors.activeGreen, '+', 'Incomes'),
  balance(CupertinoColors.activeBlue, '', 'Balance'),
  expense(CupertinoColors.destructiveRed, '-', 'Expenses');

  final Color color;
  final String prefix;
  final String title;
  const Selection(this.color, this.prefix, this.title);
}
