import 'package:flutter/cupertino.dart';
import 'selection.dart';

/// Custom Widget that represents the SegmentedControlWidget for selection view [income, balance, expense]
/// This widget uses CupertinoSlidingSegmentedControl based on Cupertino Design Guidelines
class SegmentedControlWidget extends StatelessWidget {
  // Requires the currently selected segment and the callback to handle value changes
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
        thumbColor: selectedSegment
            .color, // Set the color of the thumb based on the selected segment
        groupValue: selectedSegment, // currently selected value
        onValueChanged: onValueChanged,
        children: Selection.values.asMap().map(
              // Create a map of the children widgets for each segment
              (index, selection) => MapEntry(
                selection,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    selection.title,
                    style: const TextStyle(color: CupertinoColors.white),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
