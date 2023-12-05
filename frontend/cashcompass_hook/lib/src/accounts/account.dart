import 'dart:developer';
import 'package:cashcompass_hook/src/dtos/data_class.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

abstract class Account extends DataClass {
  final List<Transaction> sollT = [];
  final List<Transaction> habenT = [];
  final String name;

  // creatable locally and is only dependent on one user
  final int accountNumber;
  Account(
      {required super.dto, required this.name, required this.accountNumber});

  void appendTransaction(Transaction transaction) {
    if (transaction.soll == this) {
      sollT.add(transaction);
    } else if (transaction.haben == this) {
      habenT.add(transaction);
    } else {
      log("$transaction does not include $name(${dto.id})");
    }
  }

  double getSollAmount() {
    double amount = 0;
    for (var t in sollT) {
      amount += t.amount;
    }
    return amount;
  }

  double getHabenAmount() {
    double amount = 0;
    for (var t in habenT) {
      amount += t.amount;
    }
    return amount;
  }

  double close();

  @override
  String toString() {
    return "Account: $name";
  }
}
