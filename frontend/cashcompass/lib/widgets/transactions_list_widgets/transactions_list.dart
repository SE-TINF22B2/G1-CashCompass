import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/data_storage/accoutmanager.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';
import 'package:flutter/cupertino.dart';

class TransactionsList extends StatefulWidget {
  final List<Transaction> transactions;
  const TransactionsList({super.key, required this.transactions});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          CupertinoListSection.insetGrouped(
            children: <CupertinoListTile>[
              const CupertinoListTile(
                  title: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("amount"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 6,
                        child: Text("title"),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("wallet"),
                      ),
                    ],
                  ),
                  leading: Icon(
                    CupertinoIcons.arrow_down_right_arrow_up_left,
                    color: CupertinoColors.black,
                  ),
                  trailing: Text("cat")),
              CupertinoListTile(
                title: Center(
                  child: CupertinoButton(
                    onPressed: handleAddTransaction,
                    child: const Text("NEW"),
                  ),
                ),
              ),
              ...widget.transactions.map((transaction) {
                return CupertinoListTile(
                  title: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "${transaction.amount}€",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(transaction.soll.name),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(transaction.haben.name),
                      ),
                    ],
                  ),
                  leading: Icon(
                    CupertinoIcons.plus,
                    color: CupertinoColors.black,
                  ),
                  trailing: Icon(
                    CupertinoIcons.briefcase_fill,
                    color: CupertinoColors.black,
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  void handleAddTransaction() {}
}

class MockTransactions {
  static Accountmanager manager = Accountmanager();
  static generateTransactions() {
    var fac = TransactionsFactory(manager);
    var soll = PassiveAccount("mockSoll", 1);
    var haben = PassiveAccount("mockHaben", 1);
    return [
      fac.create(amount: 100.00, soll: soll, haben: haben).build(),
      fac.create(amount: 6.50, soll: soll, haben: haben).build(),
      fac.create(amount: 25.00, soll: soll, haben: haben).build(),
      fac.create(amount: 50.00, soll: soll, haben: haben).build(),
      fac.create(amount: 450.00, soll: soll, haben: haben).build(),
    ];
  }
}
