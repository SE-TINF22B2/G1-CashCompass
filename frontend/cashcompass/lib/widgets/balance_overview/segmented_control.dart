import 'package:flutter/cupertino.dart';

class BalanceSegmentedControl extends StatefulWidget {
  const BalanceSegmentedControl({super.key});

  @override
  State<BalanceSegmentedControl> createState() =>
      BalanceSegmentedControlState();
}

enum Selection { income, balance, expense }

//create Map for segmented control
Map<Selection, Color> _segmentedControlSelections = <Selection, Color>{
  Selection.income: const Color.fromRGBO(52, 199, 89, 50),
  Selection.balance: const Color.fromRGBO(50, 173, 230, 50),
  Selection.expense: const Color.fromRGBO(255, 59, 48, 50)
};

class BalanceSegmentedControlState extends State<BalanceSegmentedControl> {
  late Selection _selectedSegment;

  @override
  void initState() {
    super.initState();
    _selectedSegment = Selection.balance;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<Selection>(
      backgroundColor: CupertinoColors.systemGrey2,
      thumbColor: _segmentedControlSelections[_selectedSegment]!,
      groupValue: _selectedSegment,
      onValueChanged: (Selection? value) {
        if (value != null) {
          setState(() {
            _selectedSegment = value;
          });
        }
      },
      children: const <Selection, Widget>{
        Selection.income: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Incomes',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Selection.balance: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Balance',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Selection.expense: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Expenses',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      },
    );
  }
}
