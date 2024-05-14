import 'package:cashcompass/widgets/balance_overview/segmented_control.dart';
import 'package:flutter/cupertino.dart';

class BalanceOverview extends StatefulWidget {
  const BalanceOverview({super.key});

  @override
  State<BalanceOverview> createState() => _BalanceOverviewState();
}

class _BalanceOverviewState extends State<BalanceOverview> {
  @override
  Widget build(BuildContext context) {
    return BalanceSegmentedControl();
  }
}
