import 'package:flutter/cupertino.dart';

class LatestTransactionsScreen extends StatefulWidget {
  const LatestTransactionsScreen({super.key});

  @override
  State<LatestTransactionsScreen> createState() =>
      _LatestTransactionsScreenState();
}

class _LatestTransactionsScreenState extends State<LatestTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Latest Transactions'));
  }
}
