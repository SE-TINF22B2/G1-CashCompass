import 'package:flutter/cupertino.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({super.key});

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
              const CupertinoListTile(
                title: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "100.00€",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text("Geschenk"),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("ING"),
                    ),
                  ],
                ),
                leading: Icon(
                  CupertinoIcons.plus,
                  color: CupertinoColors.black,
                ),
                trailing: Icon(
                  CupertinoIcons.gift,
                  color: CupertinoColors.black,
                ),
              ),
              const CupertinoListTile(
                title: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "6.50€",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text("Döner"),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("Sparkasse"),
                    ),
                  ],
                ),
                leading: Icon(
                  CupertinoIcons.minus,
                  color: CupertinoColors.black,
                ),
                trailing: Icon(
                  CupertinoIcons.shopping_cart,
                  color: CupertinoColors.black,
                ),
              ),
              const CupertinoListTile(
                title: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "25.00€",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text("Fahrkosten für Rudi"),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("ING"),
                    ),
                  ],
                ),
                leading: Icon(
                  CupertinoIcons.minus,
                  color: CupertinoColors.black,
                ),
                trailing: Icon(
                  CupertinoIcons.car,
                  color: CupertinoColors.black,
                ),
              ),
              const CupertinoListTile(
                title: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "50.00€",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text("Putzen bei Omi"),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("BAR"),
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
              ),
              const CupertinoListTile(
                title: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "450.00€",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text("Gehalt"),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("ING"),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  void handleAddTransaction() {}
}
