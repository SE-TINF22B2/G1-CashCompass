import 'package:flutter/cupertino.dart';
import 'selection.dart';

class TotalDisplay extends StatelessWidget {
  final double total;
  final Selection selectedSegment;

  const TotalDisplay({
    super.key,
    required this.total,
    required this.selectedSegment,
  });

  @override
  Widget build(BuildContext context) {
    //format total String for widget
    final String formattedTotal =
        '${selectedSegment.prefix}${total.toStringAsFixed(2)}€';

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
          formattedTotal,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: selectedSegment.color,
          ),
        )
      ],
    );
  }
}
