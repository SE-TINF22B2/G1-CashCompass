import 'package:cashcompass/widgets/balance_overview/view_option.dart';
import 'package:flutter/cupertino.dart';

class ViewOptionSegmentedControl extends StatelessWidget {
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
