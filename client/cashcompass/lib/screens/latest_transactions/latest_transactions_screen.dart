import 'package:cashcompass/widgets/transactions_list_widgets/transactions_list.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/transactions_list_widgets/mock_transaction_list.dart';

class LatestTransactionsScreen extends StatefulWidget {
  const LatestTransactionsScreen({super.key});

  @override
  State<LatestTransactionsScreen> createState() =>
      _LatestTransactionsScreenState();
}

class _LatestTransactionsScreenState extends State<LatestTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Latest Transactions"),
      ),
      child: SafeArea(
        child: TransactionsList(
          transactions: MockTransactions.generateTransactions(),
        ),
      ),
    );
  }
}
