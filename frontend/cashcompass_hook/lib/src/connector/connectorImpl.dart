import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/account_connector.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';

// one connector reprents the connection to one User's data.

abstract class ConnectorImpl with AccountConnector, TransactionConnector {
  Connector({required String id});
  Future<List<Account>> getAllAccounts();
}
