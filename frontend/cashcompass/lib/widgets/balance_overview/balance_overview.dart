import 'package:cashcompass/widgets/balance_overview/mock_transaction_item.dart';
import 'package:cashcompass/widgets/balance_overview/segmented_control.dart';
import 'package:cashcompass/widgets/balance_overview/total_display.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'selection.dart';
import 'package:intl/intl.dart';

class BalanceOverview extends StatefulWidget {
  final double totalValue;
  final List<TransactionItem> incomes;
  final List<TransactionItem> expenses;

  const BalanceOverview({
    super.key,
    required this.totalValue,
    required this.incomes,
    required this.expenses,
  });

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
        const SizedBox(height: 20),
        TotalDisplay(
            total: widget.totalValue, selectedSegment: _selectedSegment),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    if (_selectedSegment == Selection.income) {
      return _buildPieChart(widget.incomes);
    } else if (_selectedSegment == Selection.expense) {
      return _buildPieChart(widget.expenses);
    } else {
      return const Center(
        child: Text(
          'Balance Overview',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Widget _buildPieChart(List<TransactionItem> items) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              sections: _generatePieChartSections(items),
              centerSpaceRadius: double.infinity,
            ),
            swapAnimationDuration: Duration(milliseconds: 150), // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
          _buildCenterButton()
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    // Hier den aktuellen Monat ermitteln
    String currentMonth = DateFormat.MMMM().format(DateTime.now());

    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all<CircleBorder>(
          CircleBorder(),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.all(100), // Hier die Größe des Buttons einstellen
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Text(
        currentMonth,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections(
      List<TransactionItem> items) {
    return items.map((item) {
      return PieChartSectionData(
          color: item.color,
          value: item.value,
          showTitle: false,
          radius: 50.0,
          titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          badgeWidget: Icon(
            item.icon,
            color: CupertinoColors.white,
          ));
    }).toList();
  }
}
