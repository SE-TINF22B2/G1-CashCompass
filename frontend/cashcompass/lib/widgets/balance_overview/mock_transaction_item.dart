// transaction_item.dart
import 'package:flutter/material.dart';

class TransactionItem {
  final String name;
  final IconData icon;
  final Color color;
  final double value;

  TransactionItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.value,
  });
}
