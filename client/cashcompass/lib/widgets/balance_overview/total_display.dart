import 'package:flutter/cupertino.dart';
import 'selection.dart';

/// Custom Widget that displays the totalValue on the screen
/// Depending on the selected view [income, balance, expenses] the color of the text changes
/// income -> green, balance -> green, expense -> red
class TotalDisplay extends StatelessWidget {
  // Widget expects the totalValue and the current view
  final double total;
  final Selection selectedSegment;

  const TotalDisplay({
    super.key,
    required this.total,
    required this.selectedSegment,
  });

  @override
  Widget build(BuildContext context) {
    /// Format totalValue String for the Text widget
    /// Adds the prefix depending on current view [+, ,-] and adds the currency at the end
    /// (Currently hardcoded on Euro, maybe we support different currencies later, then we have to change that fixed code)
    final String formattedTotal =
        '${selectedSegment.prefix}${total.toStringAsFixed(2)}€';

    // Widget consist of two Text widgets that are presented side by side which is implemented via a Row Widget
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'TOTAL: ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formattedTotal, //uses the totalValue which was formatted above
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: selectedSegment
                .color, // loads the color of the current view [green, blue, red]
          ),
        )
      ],
    );
  }
}
