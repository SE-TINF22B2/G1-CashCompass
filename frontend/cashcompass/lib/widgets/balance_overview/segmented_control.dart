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
        children: Selection.values.asMap().map(
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
