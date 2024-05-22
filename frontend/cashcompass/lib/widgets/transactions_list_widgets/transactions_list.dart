import 'package:cashcompass/widgets/transactions_list_widgets/InterpretedTransaction.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_icons.dart';
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
                        child: Text(transaction.label),
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
              }),
            ],
          ),
        ],
      ),
    );
  }

  InterpretedTransaction _interpretTransaction(Transaction transaction) {
    final soll = transaction.soll;
    final haben = transaction.haben;
    ActiveAcount wallet;
    Category category;
    IconData signIcon;
    if (soll.runtimeType == Category && haben.runtimeType == Category) {
      print('Transaction between two passive accounts not yet managed!');
      throw TypeError();
    } else if (soll.runtimeType == ActiveAcount &&
        haben.runtimeType == ActiveAcount) {
      print('Transfer not yet implemented!');
      throw TypeError();
    } else if (soll.runtimeType == ActiveAcount &&
        haben.runtimeType == Category) {
      category = haben as Category;
      wallet = soll as ActiveAcount;
      signIcon = CupertinoIcons.minus;
    } else if (soll.runtimeType == Category &&
        haben.runtimeType == ActiveAcount) {
      category = soll as Category;
      wallet = haben as ActiveAcount;
      signIcon = CupertinoIcons.plus;
    } else {
      throw TypeError();
    }
    return InterpretedTransaction(
      walletName: wallet.name,
      categoryIcon: CategoryIcons.fromName(category.iconString).icon,
      signIcon: signIcon,
    );
  }

  void handleAddTransaction() {}

  void _handleTransactionListTileTapped() {
    print('Not yet implemented');
  }
}
