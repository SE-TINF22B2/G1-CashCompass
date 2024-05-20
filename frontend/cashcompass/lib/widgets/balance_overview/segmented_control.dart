// segmented_control_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'selection.dart';

class SegmentedControlWidget extends StatelessWidget {
  final Selection selectedSegment;
  final ValueChanged<Selection?> onValueChanged;

  const SegmentedControlWidget({
    Key? key,
    required this.selectedSegment,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<Selection>(
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
    );
  }
}
