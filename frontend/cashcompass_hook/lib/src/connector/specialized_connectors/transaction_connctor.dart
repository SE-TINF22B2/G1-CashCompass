import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/connector_spez.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

mixin TransactionConnector implements ConnectorSpez {
  Future<Transaction> createTransaction(
      {Account soll,
      Account haben,
      double amount,
      DateTime timestamp,
      int transactionNumber});
  Future<double> changeAmount(Transaction transaction, double newAmount);
}
