import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/account_connector.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';

// one connector reprents the connection to one User's data.

abstract class Connector with AccountConnector, TransactionConnector {
  final String userId;
  Connector({required this.userId});
  Future<List<Account>> getAllAccounts();
}
