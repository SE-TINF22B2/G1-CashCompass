import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Selection { income, expense }

class TransactionsDetailScreen extends StatefulWidget {
  bool editMode;
  TransactionsDetailScreen({Key? key, required this.editMode})
      : super(key: key);

  @override
  _TransactionsDetailScreenState createState() =>
      _TransactionsDetailScreenState();
}

class _TransactionsDetailScreenState extends State<TransactionsDetailScreen> {
  Selection? selectedValue = Selection.income;
  List<String> labels = [
    'Amount',
    'Wallet',
    'Category',
    'Date',
    'Title',
    'Note'
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Transaction Detail"),
        trailing: IconButton(
          icon: Icon(CupertinoIcons.pencil),
          onPressed: () {
            setState(() {
              widget.editMode = !widget.editMode;
            });
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: CupertinoSlidingSegmentedControl<Selection>(
                    onValueChanged: handleExpenseIncomeChanged,
                    children: {
                      Selection.income: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Income'),
                      ),
                      Selection.expense: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Expense'),
                      ),
                    },
                    groupValue: selectedValue,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(8),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(0.3),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: List.generate(
                      6,
                      (index) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(labels[index]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CupertinoTextField(
                                  readOnly: !widget.editMode,
                                ),
                              ),
                            ],
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CupertinoButton(
                  child: Text(!widget.editMode ? "DELETE" : "SAVE"),
                  onPressed: handleDeleteTransaction,
                  color: !widget.editMode
                      ? CupertinoColors.systemRed
                      : CupertinoColors.systemGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleExpenseIncomeChanged(Selection? selection) {
    setState(() {
      selectedValue = selection;
    });
  }

  void handleDeleteTransaction() {}
}
