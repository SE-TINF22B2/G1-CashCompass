import 'package:cashcompass/components/segmented_text.dart';
import "package:flutter/cupertino.dart";

enum OverviewState {
  income(color: CupertinoColors.systemGreen, list: [1.0, 2.0, 30.2]),
  balance(color: CupertinoColors.activeBlue, list: []),
  expense(color: CupertinoColors.systemRed, list: [1, 2, 3]);

  const OverviewState({required this.color, required this.list});

  final Color color;
  final List<double> list;
}

final Map<OverviewState, Widget> logoWidgets = <OverviewState, Widget>{
  OverviewState.income: const SegmenedText(title: "Income"),
  OverviewState.balance: const SegmenedText(title: "Balance"),
  OverviewState.expense: const SegmenedText(title: "Expense")
};

class SegmentedControl extends StatefulWidget {
  const SegmentedControl({super.key});

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  //initialise selectedSegment
  OverviewState _selectedSegment = OverviewState.income;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CupertinoSlidingSegmentedControl<OverviewState>(
            backgroundColor: CupertinoColors.systemGrey,
            thumbColor: _selectedSegment.color,
            children: logoWidgets,
            onValueChanged: (OverviewState? val) {
              if (val != null) {
                setState(() {
                  _selectedSegment = val;
                });
              }
            },
            groupValue: _selectedSegment,
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
