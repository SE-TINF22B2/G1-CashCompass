import 'dart:math';

import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

/// This class stores all dataclasses of the client for basically caching them on the device in the app.
/// This enables calles which are not asynchronous for accessing the data.
class Datastorage {
  final List<PassiveAccount> passiveAccounts = [];
  final List<ActiveAccount> activeAccounts = [];
  final List<Category> categories = [];
  final List<Transaction> transactions = [];
  final List<RecurringTransactions> recurringTransactions = [];

  List<RemoteBookable> get allRemoteAccounts {
    var l = <RemoteBookable>[];
    l.addAll(activeAccounts);
    l.addAll(passiveAccounts);
    l.addAll(categories);
    return l;
  }

  int getNewAccountNumber() {
    var allNumbers = allRemoteAccounts.map((e) => e.accountNumber);
    if (allNumbers.isEmpty) {
      return 1;
    }
    return allNumbers.reduce((value, element) => max(value, element)) + 1;
  }

  int getNewTransactionNumber() {
    var allNumbers = transactions.map((e) => e.transactionNumber);
    if (allNumbers.isEmpty) {
      return 1;
    }
    return allNumbers.reduce((value, element) => max(value, element)) + 1;
  }
}
