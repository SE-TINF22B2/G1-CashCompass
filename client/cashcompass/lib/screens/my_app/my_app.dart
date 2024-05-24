import 'package:cashcompass/widgets/balance_overview/balance_overview.dart';
import 'package:cashcompass/widgets/balance_overview/mock_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:cashcompass/screens/auth_screen/auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<CategoryMock> incomes = [
      CategoryMock(
          name: 'Salary',
          icon: CupertinoIcons.money_dollar,
          color: CupertinoColors.activeBlue,
          totalValue: 5000),
      CategoryMock(
          name: 'Freelance',
          icon: CupertinoIcons.briefcase,
          color: CupertinoColors.activeGreen,
          totalValue: 2000),
      CategoryMock(
          name: 'Investment',
          icon: CupertinoIcons.bitcoin_circle,
          color: CupertinoColors.black,
          totalValue: 1500),
      CategoryMock(
          name: 'Gift',
          icon: CupertinoIcons.gift,
          color: CupertinoColors.systemPurple,
          totalValue: 300),
    ];

    List<CategoryMock> expenses = [
      CategoryMock(
          name: 'Rent',
          icon: CupertinoIcons.house,
          color: CupertinoColors.systemRed,
          totalValue: 1500),
      CategoryMock(
          name: 'Groceries',
          icon: CupertinoIcons.cart,
          color: CupertinoColors.activeOrange,
          totalValue: 300),
      CategoryMock(
          name: 'Transport',
          icon: CupertinoIcons.car,
          color: CupertinoColors.activeBlue,
          totalValue: 200),
      CategoryMock(
          name: 'Utilities',
          icon: CupertinoIcons.lightbulb,
          color: CupertinoColors.systemCyan,
          totalValue: 150),
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
