import 'view_option.dart';
import 'package:flutter/cupertino.dart';

/// Custom Widget that represents the SegmentedControlWidget for time view option [day, month, year]
/// This widget uses CupertinoSlidingSegmentedControl based on Cupertino Design Guidelines
class ViewOptionSegmentedControl extends StatelessWidget {
  // Requires the currently selected segment and the callback to handle value changes
  final ViewOption selectedSegment;
  final ValueChanged<ViewOption?> onValueChanged;

  const ViewOptionSegmentedControl({
    super.key,
    required this.selectedSegment,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<ViewOption>(
      backgroundColor: CupertinoColors.systemGrey2,
      groupValue: selectedSegment,
      onValueChanged: onValueChanged,
      thumbColor: CupertinoColors.systemBlue,
      children: ViewOption.values.asMap().map(
            // Create a map of the children widgets for each segments
            (index, viewOption) => MapEntry(
              viewOption,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  viewOption.title,
                  style: const TextStyle(color: CupertinoColors.white),
                ),
              ),
            ),
          ),
    );
  }
}
