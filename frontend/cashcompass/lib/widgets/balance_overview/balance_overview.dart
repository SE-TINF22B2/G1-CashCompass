import 'package:cashcompass/widgets/balance_overview/date_selector.dart';
import 'package:cashcompass/widgets/balance_overview/mock_transaction_item.dart';
import 'package:cashcompass/widgets/balance_overview/segmented_control.dart';
import 'package:cashcompass/widgets/balance_overview/total_display.dart';
import 'package:cashcompass/widgets/balance_overview/view_option.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'selection.dart';
import 'package:intl/intl.dart';

class BalanceOverview extends StatefulWidget {
  final List<TransactionItem> incomes;
  final List<TransactionItem> expenses;

  const BalanceOverview({
    super.key,
    required this.incomes,
    required this.expenses,
  });

  @override
  State<BalanceOverview> createState() => _BalanceOverviewState();
}

class _BalanceOverviewState extends State<BalanceOverview> {
  Selection _selectedSegment = Selection.balance;
  DateTime _selectedDate = DateTime.now();
  ViewOption _viewOption = ViewOption.month;

  //angezeigter String auf dem Button
  String currentDate = DateFormat.MMMM().format(DateTime.now());

  //Berechnung der total Values für Incomes und Expenses
  double get totalIncomes =>
      widget.incomes.fold(0, (sum, item) => sum + item.value);
  double get totalExpenses =>
      widget.expenses.fold(0, (sum, item) => sum + item.value);

  double get totalValue {
    if (_selectedSegment == Selection.income) {
      return totalIncomes;
    } else if (_selectedSegment == Selection.expense) {
      return totalExpenses;
    } else if (_selectedSegment == Selection.balance) {
      return totalIncomes - totalExpenses;
    }
    return 0;
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
        TotalDisplay(total: totalValue, selectedSegment: _selectedSegment),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    if (_selectedSegment == Selection.income) {
      return _buildPieChart(widget.incomes);
    } else if (_selectedSegment == Selection.expense) {
      return _buildPieChart(widget.expenses);
    } else {
      return _buildBalanceContainer();
    }
  }

  Widget _buildPieChart(List<TransactionItem> items) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                sections: _generatePieChartSections(items),
                centerSpaceRadius: double.infinity,
              ),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
          _buildCenterButton()
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: CupertinoButton(
          onPressed: () => _selectDate(context),
          child: FittedBox(
            child: Text(
              currentDate,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
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
          radius: 60.0,
          badgeWidget: Icon(
            item.icon,
            color: CupertinoColors.white,
          ));
    }).toList();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DateSelectorPopup(
          initialDate: _selectedDate,
          initialViewOption: _viewOption,
          onDateSelected: (newDate, newViewOption) {
            _selectedDate = newDate;
            _viewOption = newViewOption;
          },
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;

        switch (_viewOption) {
          case ViewOption.day:
            currentDate = DateFormat.yMMMMd().format(picked);
            break;
          case ViewOption.month:
            currentDate = DateFormat.MMMM().format(picked);
            break;
          case ViewOption.year:
            currentDate = DateFormat.y().format(picked);
            break;
        }
      });
    }
  }

  Widget _buildBalanceContainer() {
    double total = totalIncomes + totalExpenses;
    double incomeFraction = totalIncomes / total;
    double expenseFraction = totalExpenses / total;

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                height: 400 * incomeFraction,
                decoration: BoxDecoration(
                  color: CupertinoColors.activeGreen.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0), // Rundung oben links
                    topRight: Radius.circular(20.0), // Rundung oben rechts
                    bottomLeft:
                        Radius.circular(0.0), // keine Rundung unten links
                    bottomRight:
                        Radius.circular(0.0), // keine Rundung unten rechts
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '+${totalIncomes.toStringAsFixed(2)}€',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 400 * expenseFraction,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemRed.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0.0), // keine Rundung oben links
                    topRight: Radius.circular(0.0), // keine Rundung oben rechts
                    bottomLeft: Radius.circular(20.0), // Rundung unten links
                    bottomRight: Radius.circular(20.0), // Rundung unten rechts
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-${totalExpenses.toStringAsFixed(2)}€',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildBalanceCenterButton()
        ],
      ),
    );
  }

  Widget _buildBalanceCenterButton() {
    return Padding(
      padding: const EdgeInsets.all(70.0),
      child: ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: CupertinoButton.filled(
            onPressed: () => _selectDate(context),
            child: FittedBox(
              child: Text(
                currentDate,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
