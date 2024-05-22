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
      children: const <ViewOption, Widget>{
        ViewOption.day: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'Day',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        ViewOption.month: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'Month',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        ViewOption.year: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'Year',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      },
    );
  }
}
