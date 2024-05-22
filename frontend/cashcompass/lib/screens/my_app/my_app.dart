import 'package:cashcompass/widgets/balance_overview/balance_overview.dart';
import 'package:cashcompass/widgets/balance_overview/mock_transaction_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:cashcompass/screens/auth_screen/auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<TransactionItem> incomes = [
      TransactionItem(
          name: 'Salary',
          icon: CupertinoIcons.money_dollar,
          color: CupertinoColors.activeBlue,
          value: 5000),
      TransactionItem(
          name: 'Freelance',
          icon: CupertinoIcons.briefcase,
          color: CupertinoColors.activeGreen,
          value: 2000),
      TransactionItem(
          name: 'Investment',
          icon: CupertinoIcons.bitcoin_circle,
          color: CupertinoColors.black,
          value: 1500),
      TransactionItem(
          name: 'Gift',
          icon: CupertinoIcons.gift,
          color: CupertinoColors.systemPurple,
          value: 300),
    ];

    List<TransactionItem> expenses = [
      TransactionItem(
          name: 'Rent',
          icon: CupertinoIcons.house,
          color: CupertinoColors.systemRed,
          value: 1500),
      TransactionItem(
          name: 'Groceries',
          icon: CupertinoIcons.cart,
          color: CupertinoColors.activeOrange,
          value: 300),
      TransactionItem(
          name: 'Transport',
          icon: CupertinoIcons.car,
          color: CupertinoColors.activeBlue,
          value: 200),
      TransactionItem(
          name: 'Utilities',
          icon: CupertinoIcons.lightbulb,
          color: CupertinoColors.systemCyan,
          value: 150),
    ];

    return CupertinoApp(
        title: 'Flutter Demo',
        theme: CupertinoThemeData(),
        home: CupertinoPageScaffold(
          child: SafeArea(
            child: BalanceOverview(
              incomes: incomes,
              expenses: expenses,
            ),
          ),
        ));
  }
}
