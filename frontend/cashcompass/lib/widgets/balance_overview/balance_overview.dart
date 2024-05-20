import 'package:cashcompass/widgets/balance_overview/segmented_control.dart';
import 'package:cashcompass/widgets/balance_overview/total_display.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'selection.dart';

class BalanceOverview extends StatefulWidget {
  final double totalValue;

  const BalanceOverview({super.key, required this.totalValue});

  @override
  State<BalanceOverview> createState() => _BalanceOverviewState();
}

class _BalanceOverviewState extends State<BalanceOverview> {
  late Selection _selectedSegment;

  @override
  void initState() {
    super.initState();
    _selectedSegment = Selection.balance;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedControlWidget(
            selectedSegment: _selectedSegment,
            onValueChanged: (Selection? value) {
              if (value != null) {
                setState(() {
                  _selectedSegment = value;
                });
              }
            }),
        TotalDisplay(
            total: widget.totalValue, selectedSegment: _selectedSegment),
        Expanded(
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  sections: showingSections(),
                  centerSpaceRadius: double.infinity,
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              )
            ],
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (index) {
        const fontSize = 16.0;
        const radius = 50.0;
        switch (index) {
          case 0:
            return PieChartSectionData(
              color: Colors.blue,
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: Colors.yellow,
              value: 30,
              showTitle: false,
              radius: radius,
              badgeWidget: Icon(
                Icons.kayaking_outlined,
                color: Colors.black,
              ),
              titleStyle: const TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            );
          case 2:
            return PieChartSectionData(
              color: Colors.purple,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: fontSize,
              ),
            );
          case 3:
            return PieChartSectionData(
              color: Colors.green,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: const TextStyle(
                  fontSize: fontSize, fontWeight: FontWeight.bold),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
