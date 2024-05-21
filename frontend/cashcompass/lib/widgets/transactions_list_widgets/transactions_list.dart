ximport 'package:cashcompass/widgets/transactions_list_widgets/InterpretedTransaction.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';
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
                InterpretedTransaction interpretedTransaction =
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
                  onTap: _handleTransactionListTileTapped,
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  InterpretedTransaction _interpretTransaction(Transaction transaction) {
    final soll = transaction.soll;
    final haben = transaction.haben;
    var walletName;
    // var categoryIcon;
    var signIcon;
    if (soll.runtimeType == PassiveAccount &&
        haben.runtimeType == PassiveAccount) {
      print('Transaction between two passive accounts not yet managed!');
    } else if (soll.runtimeType == ActiveAcount &&
        haben.runtimeType == ActiveAcount) {
      print('Transfer not yet implemented!');
    } else if (soll.runtimeType == ActiveAcount &&
        haben.runtimeType == PassiveAccount) {
      (soll as Category).name;
      walletName = soll.name;
      signIcon = CupertinoIcons.minus;
    } else if (soll.runtimeType == PassiveAccount &&
        haben.runtimeType == ActiveAcount) {
      walletName = haben.name;
      signIcon = CupertinoIcons.plus;
    } else {
      throw TypeError();
    }
    return new InterpretedTransaction(
      walletName: walletName,
      // categoryIcon: categoryIcon,
      signIcon: signIcon,
    );
  }

  void handleAddTransaction() {}

  void _handleTransactionListTileTapped() {
    print('Not yet implemented');
  }
}
