import 'package:cashcompass/controller/controller.dart';
import 'package:cashcompass/widgets/balance_overview/balance_overview.dart';
import 'package:cashcompass/widgets/transactions_list_widgets/transactions_list.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/chart_of_accounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/balance_overview/mock_transaction.dart';

class CategoriesDetailScreen extends StatefulWidget {
  const CategoriesDetailScreen({super.key});

  @override
  State<CategoriesDetailScreen> createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  late final ChartOfAccounts chart;
  late List<Category> d1;
  late List<Category> d2;
  late List<Category> list;
  late List<CategoryMock> c1;
  late List<CategoryMock> c2;

  @override
  void initState() {
    super.initState();
    chart = ChartOfAccounts(Controller.accountManager);
    d1 = chart.getCategories().where((category) {
      return category.close() >= 0;
    }).toList(); //get incomes
    d2 = chart.getCategories().where((category) {
      return category.close() < 0;
    }).toList(); //get expenses
    list = chart.getCategories(); //get all

    c1 = d1
        .map((Category c1) => CategoryMock(
            name: c1.name,
            icon: Icons.abc,
            color: Colors.black,
            totalValue: 1.1))
        .toList();
    c2 = d2
        .map((Category c2) => CategoryMock(
            name: c2.name,
            icon: Icons.baby_changing_station,
            color: Colors.red,
            totalValue: 2.0))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Category Name"),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BalanceOverview(
                incomes: c1,
                expenses: c2,
              ),
              TransactionsList(
                transactions: Controller.accountManager.data.transactions,
              )
            ],
          ),
        ),
      ),
    );
  }
}
