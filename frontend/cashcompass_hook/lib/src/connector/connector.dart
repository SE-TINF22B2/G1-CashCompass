import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/account_connector.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';

// one connector reprents the connection to one User's data.

abstract class Connector with AccountConnector, TransactionConnector {
  final String hostname;
  final String? port;
  String get url => "$hostname ${port != null ? ':$port' : ''}";
  const Connector(this.hostname, this.port);
  Future<List<Account>> getAllAccounts();
}
