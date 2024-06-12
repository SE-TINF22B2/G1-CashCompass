import 'package:cashcompass/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/balance_overview/balance_overview.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/chart_of_accounts.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import '../../widgets/balance_overview/mock_transaction.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_icons.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import '../../widgets/balance_overview/total_display.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({super.key});

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  late final ChartOfAccounts chart;
  late List<ActiveAccount> list;

  @override
  void initState() {
    super.initState();
    chart = ChartOfAccounts(Controller.accountManager);

    list = chart.getActiveAccounts(); //get all
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Wallets"),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'TOTAL: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                getTotal().toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemBlue,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
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
                    ActiveAccount activeAccount = list[index - 1];

                    return CupertinoListTile(
                      title: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(activeAccount.name),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${activeAccount.close()}€",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
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

  void handleAddCategory() {
    throw UnsupportedError("Not yet implemented");
  }

  void _handleCategoryListTileTapped() {
    throw UnsupportedError("Not yet implemented");
  }

  double getTotal() {
    double total = 0;
    for (ActiveAccount activeAccount in list) {
      total += activeAccount.close();
    }
    return total;
  }
}

class InterpretedCategory {
  IconData categoryIcon;

  InterpretedCategory({this.categoryIcon = Icons.info});
}
