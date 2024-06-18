import 'package:cashcompass/controller/controller.dart';
import 'package:cashcompass/screens/transactions_detail_screen/transactions_detail_screen.dart';
import 'package:cashcompass/widgets/transactions_list_widgets/InterpretedTransaction.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_icons.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';
import 'package:flutter/cupertino.dart';

InterpretedTransaction interpretTransaction(Transaction transaction) {
  final Bookable soll = transaction.soll;
  final Bookable haben = transaction.haben;
  late ActiveAccount wallet;
  late Category category;
  late IconData signIcon;
  late bool isExpense;

  if (soll is Category && haben is Category) {
    throw UnsupportedError("Transaction of two PassiveAccounts not managed!");
  } else if (soll is ActiveAccount && haben is ActiveAccount) {
    throw UnsupportedError("Transfer not yet implemented!");
  } else if (soll is ActiveAccount && haben is Category) {
    category = haben;
    wallet = soll;
    signIcon = CupertinoIcons.minus;
    isExpense = true;
  } else if (soll is Category && haben is ActiveAccount) {
    category = soll;
    wallet = haben;
    signIcon = CupertinoIcons.plus;
    isExpense = false;
  } else {
    throw UnsupportedError("Unsupported Account Types!");
  }
  return InterpretedTransaction(
      walletName: wallet.name,
      categoryIcon: CategoryIcons.fromName(category.iconString).icon,
      signIcon: signIcon,
      isExpense: isExpense);
}

class TransactionsList extends StatefulWidget {
  const TransactionsList({super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  List<Transaction> transactions = [];
  @override
  void initState() {
    super.initState();
    transactions = Controller.accountManager.data.transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            ...transactions.map((transaction) {
              InterpretedTransaction interpretedTransaction =
                  interpretTransaction(transaction);
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
                onTap: () => _handleTransactionListTileTapped(transaction),
              );
            }),
          ],
        ),
      ],
    );
  }

  void handleAddTransaction() {
    Navigator.of(context)
        .push(CupertinoPageRoute(
            builder: (context) => TransactionsDetailScreen(editMode: true)))
        .then((v) {
      setState(() {
        transactions = Controller.accountManager.data.transactions;
      });
    });
  }

  void _handleTransactionListTileTapped(Transaction transaction) {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => TransactionsDetailScreen(
              editMode: false,
              transaction: transaction,
            )));
  }
}
