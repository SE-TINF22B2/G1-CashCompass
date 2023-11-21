import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/connector_spez.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

mixin TransactionConnector implements ConnectorSpez {
  Future<Transaction> createTransaction(
      {required Account soll,
      required Account haben,
      required double amount,
      required DateTime timestamp,
      required int transactionNumber});
  Future<double> changeAmount(Transaction transaction, double newAmount);
}
