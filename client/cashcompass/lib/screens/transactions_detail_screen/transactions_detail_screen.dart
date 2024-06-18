import 'package:cashcompass/widgets/transactions_list_widgets/InterpretedTransaction.dart';
import 'package:cashcompass_hook/src/accounts/category/category_icons.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/transactions_list_widgets/transactions_list.dart';

enum Selection { income, expense }

class TransactionsDetailScreen extends StatefulWidget {
  bool editMode;
  final Transaction? transaction;
  TransactionsDetailScreen({Key? key, required this.editMode, this.transaction})
      : super(key: key);

  @override
  _TransactionsDetailScreenState createState() =>
      _TransactionsDetailScreenState();
}

class _TransactionsDetailScreenState extends State<TransactionsDetailScreen> {
  Selection? selectedValue;
  late TextEditingController _amountController;
  late TextEditingController _walletController;
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  String _selectedDate = "";
  CategoryIcons selectedIcon = CategoryIcons.values.first;

  InterpretedTransaction? interpretedTransaction;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _walletController = TextEditingController();
    _titleController = TextEditingController();
    _noteController = TextEditingController();

    if (widget.transaction != null) {
      interpretedTransaction = interpretTransaction(widget.transaction!);
      _amountController.text = widget.transaction!.amount.toString();
      _walletController.text = interpretedTransaction!.walletName;
      _titleController.text = widget.transaction!.label;
      selectedValue = interpretedTransaction!.isExpense
          ? Selection.expense
          : Selection.income;

      // Set initial date from interpretedTransaction
      DateTime transactionDate =
          widget.transaction!.timestamp; // Assuming date format is yyyy-MM-dd
      _selectedDate =
          "${transactionDate.year}-${transactionDate.month.toString().padLeft(2, '0')}-${transactionDate.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _walletController.dispose();
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          color: CupertinoColors.white,
          child: DefaultTextStyle(
            style: const TextStyle(
              color: CupertinoColors.black,
              fontSize: 22.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SafeArea(
                top: false,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate =
                          "${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}";
                    });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showPicker() async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(8.0),
          color: CupertinoColors.white,
          child: CupertinoPicker(
            itemExtent: 35,
            onSelectedItemChanged: (index) {
              setState(() {
                selectedIcon = CategoryIcons.values[index];
              });
            },
            children: CategoryIcons.values
                .map((icon) => Row(
                      children: [
                        Icon(icon.icon),
                        SizedBox(width: 10),
                        Text(icon.name),
                      ],
                    ))
                .toList(),
          ),
        );
      },
    );
  }

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
        child: SingleChildScrollView(
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
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Amount'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoTextField(
                              controller: _amountController,
                              readOnly: !widget.editMode,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Wallet'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoTextField(
                              controller: _walletController,
                              readOnly: !widget.editMode,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Category'),
                          ),
                          CupertinoButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(selectedIcon.icon),
                                SizedBox(width: 10),
                                Text(selectedIcon.name),
                              ],
                            ),
                            onPressed: widget.editMode ? _showPicker : null,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Date'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: widget.editMode
                                  ? () => _selectDate(context)
                                  : null,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 44.0,
                                child: Text(
                                  _selectedDate.isEmpty
                                      ? "Select Date"
                                      : _selectedDate,
                                  style: TextStyle(
                                    color: _selectedDate.isEmpty
                                        ? CupertinoColors.placeholderText
                                        : CupertinoColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Title'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoTextField(
                              controller: _titleController,
                              readOnly: !widget.editMode,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Note'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoTextField(
                              controller: _noteController,
                              readOnly: !widget.editMode,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ],
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
      ),
    );
  }

  void handleExpenseIncomeChanged(Selection? selection) {
    setState(() {
      selectedValue = selection;
    });
  }

  void handleDeleteTransaction() {
    // Handle delete transaction functionality
  }
}
