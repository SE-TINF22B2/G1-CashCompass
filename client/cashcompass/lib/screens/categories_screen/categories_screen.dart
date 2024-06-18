import 'package:cashcompass/controller/controller.dart';
import 'package:cashcompass/screens/add_category/add_category_screen.dart';
import 'package:cashcompass/screens/categories_detail_screen/categories_detail_screen.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_icons.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/chart_of_accounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/balance_overview/balance_overview.dart';
import '../../widgets/balance_overview/mock_transaction.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
        middle: Text("Categories"),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BalanceOverview(
                incomes: c1,
                expenses: c2,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return CupertinoListTile(
                      title: Center(
                        child: CupertinoButton(
                          onPressed: handleAddCategory,
                          child: const Text("NEW"),
                        ),
                      ),
                    );
                  } else {
                    Category category = list[index - 1];
                    InterpretedCategory interpretedCategory =
                        _interpretCategory(category);

                    return CupertinoListTile(
                      title: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(category.name),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${category.close()}€",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      leading: Icon(
                        CategoryIcons.fromName(category.iconString).icon,
                        color: CupertinoColors.black,
                      ),
                      trailing: Icon(
                        interpretedCategory.categoryIcon,
                        color: CupertinoColors.black,
                      ),
                      onTap: _handleCategoryListTileTapped,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  InterpretedCategory _interpretCategory(Category category) {
    return InterpretedCategory(
      categoryIcon: Icons.info,
    );
  }

  void _handleCategoryListTileTapped() {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => const CategoriesDetailScreen()));
  }

  void handleAddCategory() {
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (context) => const AddCategoryScreen()));
  }
}

class InterpretedCategory {
  IconData categoryIcon;

  InterpretedCategory({this.categoryIcon = Icons.info});
}
