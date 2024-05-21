import 'package:cashcompass/widgets/transactions_list_widgets/mock_transaction_list.dart';
import 'package:cashcompass/widgets/transactions_list_widgets/transactions_list.dart';
import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(),
      home: TransactionsList(
        transactions: MockTransactions.generateTransactions(),
      ),
    );
  }
}
