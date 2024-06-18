import 'package:cashcompass/controller/controller.dart';
import 'package:cashcompass/widgets/transactions_list_widgets/transactions_list.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/chart_of_accounts.dart';
import 'package:flutter/cupertino.dart';

class LatestTransactionsScreen extends StatefulWidget {
  const LatestTransactionsScreen({super.key});

  @override
  State<LatestTransactionsScreen> createState() =>
      _LatestTransactionsScreenState();
}

class _LatestTransactionsScreenState extends State<LatestTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    ChartOfAccounts chartOfAccounts =
        ChartOfAccounts(Controller.accountManager);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Latest Transactions"),
      ),
      child: SafeArea(
        child: TransactionsList(),
      ),
    );
  }
}
