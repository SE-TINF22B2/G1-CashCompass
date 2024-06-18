import 'package:cashcompass/controller/controller.dart';
import 'package:cashcompass/widgets/balance_overview/balance_overview.dart';
import 'package:cashcompass/widgets/transactions_list_widgets/transactions_list.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/chart_of_accounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesDetailScreen extends StatefulWidget {
  final Category category;

  const CategoriesDetailScreen(this.category, {super.key});

  @override
  State<CategoriesDetailScreen> createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.category.name),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // BalanceOverview(
              //   incomes: mockedCategories1,
              //   expenses: mockedCategories2,
              // ),
              // TransactionsList(
              //   transactions: widget.category.,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
