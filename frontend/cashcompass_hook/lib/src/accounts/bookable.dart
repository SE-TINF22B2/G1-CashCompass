import 'dart:developer';

import 'package:cashcompass_hook/src/currency/currency.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

mixin Bookable {
  final List<Transaction> sollT = [];
  final List<Transaction> habenT = [];
  late final String name;

  // creatable locally and is only dependent on one user
  late final int accountNumber;

  Currency getSollAmount() {
    double amount = 0;
    for (var t in sollT) {
      amount += t.amount;
    }
    return amount;
  }

  Currency getHabenAmount() {
    double amount = 0;
    for (var t in habenT) {
      amount += t.amount;
    }
    return amount;
  }

  Currency close();

  @override
  String toString() {
    return "Account: $name";
  }

  void appendTransaction(Transaction transaction) {
    if (transaction.soll == this) {
      sollT.add(transaction);
    } else if (transaction.haben == this) {
      habenT.add(transaction);
    } else {
      log("$transaction does not include $name($this)");
    }
  }

  void appendTransactions(Iterable<Transaction> transactions) {
    for (var t in transactions) {
      appendTransaction(t);
    }
  }
}

abstract class LocaleBookable with Bookable {}

abstract class RemoteBookable<
    T extends DatabaseObject<T, S, F, U>,
    S extends Serializer<T>,
    F extends Factory<T, S, F, U>,
    U extends Updater<T>> with Bookable, DatabaseObject<T, S, F, U> {}
