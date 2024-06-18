import 'date_selector.dart';
import 'segmented_control.dart';
import 'total_display.dart';
import 'view_option.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'selection.dart';
import 'package:intl/intl.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/data.dart';
import 'package:cashcompass_hook/src/accounts/category/category_icons.dart';
import 'package:cashcompass/utils/hex_color.dart';

/// Custom widget for representing the overview of income, balance and expenses
/// Uses different custom widgets that are refractored in own files under
/// balance_overview directory
///
class BalanceOverview extends StatefulWidget {
  // Widget expects two list of all Categories depending on the selectedDate
  final List<Income> incomes;
  final List<Expense> expenses;

  const BalanceOverview({
    super.key,
    required this.incomes,
    required this.expenses,
  });

  @override
  State<BalanceOverview> createState() => _BalanceOverviewState();
}

class _BalanceOverviewState extends State<BalanceOverview> {
  /// At the beginning initialise some attributes
  Selection _selectedSegment = Selection.balance;
  ViewOption _viewOption = ViewOption.month;
  DateTime _selectedDate = DateTime.now();
  // Text which is shown on the center button and displays the value of _selectedDate
  late String buttonText;

  // initState() function that is called once when the widget is started for the first time
  @override
  void initState() {
    super.initState();
    buttonText = DateFormat.MMMM().format(_selectedDate);
  }

  //Calculation of total values for incomes und expenses
  double get totalIncomes =>
      widget.incomes.fold(0, (sum, item) => sum + item.transaction.amount);
  double get totalExpenses =>
      widget.expenses.fold(0, (sum, item) => sum + item.transaction.amount);

  // function that returns the total value depening on selected view [income, balance, expenses]
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
        // Custom widget that shows the SegmentedControl
        SegmentedControlWidget(
            selectedSegment: _selectedSegment,
            onValueChanged: (Selection? value) {
              if (value != null) {
                setState(() {
                  _selectedSegment =
                      value; // Update the selected segment and rebuild the widget
                });
              }
            }),
        const SizedBox(
          height: 20,
        ),
        // Custom widget TotalDisplay that displays totalValue as Text
        TotalDisplay(
          total: totalValue,
          selectedSegment: _selectedSegment,
        ),
        // Call a method to build additional content
        _buildContent(),
      ],
    );
  }

  /// Method to build the content based on the selected segment
  /// Income  -> builds a pie chart with the list of incomes
  /// Balance -> builds the chart that shows the balance between incomes and expenses
  /// Expense -> builds a pie chart with the list of expenses
  Widget _buildContent() {
    if (_selectedSegment == Selection.income) {
      return _buildPieChart(
        widget.incomes
            .map(
              (e) => _Transaction(
                icon: CategoryIcons.fromName(e.category.iconString).icon,
                color: HexColor.fromHex(e.category.colorString),
                totalValue: e.transaction.amount,
              ),
            )
            .toList(),
      );
    } else if (_selectedSegment == Selection.expense) {
      return _buildPieChart(
        widget.expenses
            .map(
              (e) => _Transaction(
                  icon: CategoryIcons.fromName(e.category.iconString).icon,
                  color: HexColor.fromHex(e.category.colorString),
                  totalValue: e.transaction.amount),
            )
            .toList(),
      );
    } else {
      return _buildBalanceContainer();
    }
  }

  /// Method to build a pie chart using a list
  /// Using the PieChart widget from the imported fl_chart package
  /// PieChart widget needs PieChartData for each section in the pie chart
  /// Icon, Color, Amount
  Widget _buildPieChart(List<_Transaction> items) {
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
                sections: _generatePieChartSections(
                    items), // Generate the sections of the pie chart
                centerSpaceRadius: double.infinity,
              ),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
          // Call a method to the center button
          _buildCenterButton()
        ],
      ),
    );
  }

  /// Method to build the center button that shows the selected date for the pie chart
  Widget _buildCenterButton() {
    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: CupertinoButton(
          onPressed: () => _selectDate(context), // Calls the
          child: FittedBox(
            child: Text(
              buttonText,
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

  // Method that generate and return a list of PieChartSectionData which are required for PieChart
  List<PieChartSectionData> _generatePieChartSections(
      List<_Transaction> items) {
    return items.map((item) {
      return PieChartSectionData(
          color: item.color,
          value: item.totalValue,
          showTitle: false,
          radius: 60.0,
          badgeWidget: Icon(
            item.icon,
            color: CupertinoColors.white,
          ));
    }).toList();
  }

  // Async function that processes the date selection with a modal popup from Cupertino
  Future<void> _selectDate(BuildContext context) async {
    // Show a Cupertino modal popup to select a date
    DateTime? picked = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        // Return a custom date selector popup widget
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

    // If a date is picked (not null), update the state
    if (picked != null) {
      setState(() {
        _selectedDate = picked;

        // Update the button text based on the selected view option
        switch (_viewOption) {
          case ViewOption.day:
            buttonText =
                DateFormat.yMMMMd().format(picked); // Format date as day
            break;
          case ViewOption.month:
            buttonText =
                DateFormat.MMMM().format(picked); // Format date as month
            break;
          case ViewOption.year:
            buttonText = DateFormat.y().format(picked); // Format date as year
            break;
        }
      });
    }
  }

  // Method to build a container displaying the balance information
  Widget _buildBalanceContainer() {
    // Calculation of the fraction for income and expense
    // needed to define the size of each container (income/expense)
    double total = totalIncomes + totalExpenses;
    double incomeFraction = total > 0 ? totalIncomes / total : 0;
    double expenseFraction = total > 0 ? totalExpenses / total : 0;

    if (incomeFraction == 0 && expenseFraction == 0) {
      incomeFraction = 0.5;
      expenseFraction = 0.5;
    }

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              // Container to display the total incomes
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
              // Container to display the total expenses
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
          // Call a method to the center button
          _buildBalanceCenterButton()
        ],
      ),
    );
  }

  /// Method to build the center button that shows the selected date for the balance overview
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
                buttonText,
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

class _Transaction {
  final IconData icon;
  final Color color;
  final double totalValue;

  _Transaction({
    required this.icon,
    required this.color,
    required this.totalValue,
  });
}
