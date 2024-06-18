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
  late List<Category> categoryList1;
  late List<Category> categoryList2;
  late List<Category> completeList;
  late List<CategoryMock> mockedCategories1;
  late List<CategoryMock> mockedCategories2;

  @override
  void initState() {
    super.initState();
    chart = ChartOfAccounts(Controller.accountManager);
    categoryList1 = chart.getCategories().where((category) {
      return category.close() >= 0;
    }).toList(); //get incomes
    categoryList2 = chart.getCategories().where((category) {
      return category.close() < 0;
    }).toList(); //get expenses
    completeList = chart.getCategories(); //get all

    mockedCategories1 = categoryList1
        .map((Category c1) => CategoryMock(
            name: c1.name,
            icon: Icons.abc,
            color: Colors.black,
            totalValue: 1.1))
        .toList();
    mockedCategories2 = categoryList2
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
                incomes: mockedCategories1,
                expenses: mockedCategories2,
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
