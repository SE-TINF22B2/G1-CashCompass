import 'package:cashcompass/controller/controller.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/chart_of_accounts.dart';
import 'package:flutter/cupertino.dart';

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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20),
              child: Text(
                'TOTAL: ' + getTotal().toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CupertinoListSection.insetGrouped(
                  children: getAccountTiles(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getAccountTiles() {
    List<Widget> tiles = [];

    tiles.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: CupertinoButton(
          onPressed: handleAddCategory,
          child: const Text("NEW"),
        ),
      ),
    );

    tiles.addAll(
      list.map((ActiveAccount activeAccount) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(activeAccount.name),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  activeAccount.close().toString() + "€",
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );

    return tiles;
  }

  void handleAddCategory() {
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
