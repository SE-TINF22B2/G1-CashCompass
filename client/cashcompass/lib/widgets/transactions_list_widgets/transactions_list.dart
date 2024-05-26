import 'package:cashcompass/widgets/transactions_list_widgets/InterpretedTransaction.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
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
    final Bookable soll = transaction.soll;
    final Bookable haben = transaction.haben;
    late ActiveAcount wallet;
    late Category category;
    late IconData signIcon;

    if (soll is Category && haben is Category) {
      throw UnsupportedError("Transaction of two PassiveAccounts not managed!");
    } else if (soll is ActiveAcount && haben is ActiveAcount) {
      throw UnsupportedError("Transfer not yet implemented!");
    } else if (soll is ActiveAcount && haben is Category) {
      category = haben;
      wallet = soll;
      signIcon = CupertinoIcons.minus;
    } else if (soll is Category && haben is ActiveAcount) {
      category = soll;
      wallet = haben;
      signIcon = CupertinoIcons.plus;
    } else {
      throw UnsupportedError("Unsupported Account Types!");
    }
    return InterpretedTransaction(
      walletName: wallet.name,
      categoryIcon: CategoryIcons.fromName(category.iconString).icon,
      signIcon: signIcon,
    );
  }

  void handleAddTransaction() {}

  void _handleTransactionListTileTapped() {
    throw UnsupportedError("Not yet implemented");
  }
}
