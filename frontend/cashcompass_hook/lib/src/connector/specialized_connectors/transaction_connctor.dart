import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/connector_spez.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

/// This class should contain every function connected to transactions.
mixin TransactionConnector implements ConnectorSpez {
  /// Creates a transaction with given attributes and returns the transactions Id.
  Future<String> createTransaction(
      {required Account soll,
      required Account haben,
      required double amount,
      required DateTime timestamp,
      required int transactionNumber});

  /// Creates a recurring transaction with given attributes and returns the transactions Id.
  Future<String> createRecurringTransaction(
      {required Account soll,
      required Account haben,
      required double amount,
      required DateTime startTimestamp,
      required DateTime endTimestamp,
      required Duration interval});

  Future<double> changeTransactionAmount(
      Transaction transaction, double newAmount);
  Future<double> changeRecurringTransactionAmount(
      RecurringTransactions recurringTransactions, double newAmount);
}
