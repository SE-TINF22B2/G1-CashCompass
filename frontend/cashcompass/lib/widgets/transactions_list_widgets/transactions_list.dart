import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
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
                _InterpretedTransaction interpretedTransaction =
                    _interpretTransaction(transaction);
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
                        child: Text("Transaction Name"),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(interpretedTransaction.walletName),
                      ),
                    ],
                  ),
                  leading: Icon(
                    interpretedTransaction.signIcon,
                    color: CupertinoColors.black,
                  ),
                  trailing: Icon(
                    interpretedTransaction.categoryIcon,
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

  _InterpretedTransaction _interpretTransaction(Transaction transaction) {
    final soll = transaction.soll;
    final haben = transaction.haben;
    var walletName;
    var categoryIcon;
    var signIcon;
    if (soll.runtimeType == PassiveAccount &&
        haben.runtimeType == PassiveAccount) {
      print('Transaction between two passive accounts not yet managed!');
    } else if (soll.runtimeType == ActiveAcount &&
        haben.runtimeType == ActiveAcount) {
      print('Transfer not yet implemented!');
    } else if (soll.runtimeType == ActiveAcount &&
        haben.runtimeType == PassiveAccount) {
      walletName = soll.name;
      signIcon = CupertinoIcons.minus;
    } else if (soll.runtimeType == PassiveAccount &&
        haben.runtimeType == ActiveAcount) {
      walletName = haben.name;
      signIcon = CupertinoIcons.plus;
    } else {
      throw TypeError();
    }
    return new _InterpretedTransaction(
        walletName: walletName, categoryIcon: categoryIcon, signIcon: signIcon);
  }
}

class MockTransactions {
  static Accountmanager manager = Accountmanager();
  static generateTransactions() {
    var fac = TransactionsFactory(manager);
    return [
      fac
          .create(
              amount: 100.00,
              soll: PassiveAccount("Geschenk", 1),
              haben: ActiveAcount("ING", 2))
          .build(),
      fac
          .create(
              amount: 6.50,
              soll: ActiveAcount("Sprakasse", 3),
              haben: PassiveAccount("Food", 4))
          .build(),
      fac
          .create(
              amount: 25.00,
              soll: ActiveAcount("ING", 5),
              haben: PassiveAccount("Mobilität", 6))
          .build(),
      fac
          .create(
              amount: 50.00,
              soll: PassiveAccount("Geschenk", 7),
              haben: ActiveAcount("BAR", 8))
          .build(),
      fac
          .create(
              amount: 450.00,
              soll: PassiveAccount("Arbeit", 9),
              haben: ActiveAcount("ING", 10))
          .build(),
    ];
  }
}

class _InterpretedTransaction {
  var walletName;
  var categoryIcon;
  var signIcon;

  _InterpretedTransaction(
      {required this.walletName,
      required this.categoryIcon,
      required this.signIcon});
}
