import 'package:cashcompass/controller/controller.dart';
import 'package:cashcompass/screens/add_category/add_category_screen.dart';
import 'package:cashcompass/screens/categories_detail_screen/categories_detail_screen.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_icons.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/chart_of_accounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/data.dart';

import '../../widgets/balance_overview/balance_overview.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final ChartOfAccounts chart;

  late List<Category> allCategories;
  late Map<Category, Iterable<Income>> incomesCategories;
  late Map<Category, Iterable<Expense>> expenseCategories;

  List<Income> incomes = List.empty();
  List<Expense> expenses = List.empty();

  @override
  void initState() {
    super.initState();
    chart = ChartOfAccounts(Controller.accountManager);

    // Get all categories from FAIL
    allCategories = chart.getCategories();

    // Get all categories from FAIL which are incomes
    incomesCategories = chart.getIncomePerCategory(null);

    incomesCategories.forEach((key, value) {
      for (var element in value) {
        incomes.add(element);
      }
    });

    // Get  all categories from FAIL which are expenses
    expenseCategories = chart.getExpencesPerCategory(null);

    expenseCategories.forEach((key, value) {
      for (var element in value) {
        expenses.add(element);
      }
    });
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
                incomes: incomes,
                expenses: expenses,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: allCategories.length + 1,
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
                    Category category = allCategories[index - 1];
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
