import 'package:flutter/cupertino.dart';
import 'selection.dart';

class SegmentedControlWidget extends StatelessWidget {
  final Selection selectedSegment;
  final ValueChanged<Selection?> onValueChanged;

  const SegmentedControlWidget({
    super.key,
    required this.selectedSegment,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CupertinoSlidingSegmentedControl<Selection>(
        backgroundColor: CupertinoColors.systemGrey2,
        thumbColor: selectedSegment.color,
        groupValue: selectedSegment,
        onValueChanged: onValueChanged,
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
      ),
    );
  }
}
