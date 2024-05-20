import 'package:flutter/cupertino.dart';

enum Selection {
  income(CupertinoColors.activeGreen, '+'),
  balance(CupertinoColors.activeBlue, ''),
  expense(CupertinoColors.destructiveRed, '-');

  final Color color;
  final String prefix;
  const Selection(this.color, this.prefix);
}
