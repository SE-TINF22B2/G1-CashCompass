import 'package:cashcompass_hook/cashcompass_hook.dart';
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:cashcompass_hook/src/connector/secured_rest_client.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/account_connector.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';

// one connector reprents the connection to one User's data.

abstract class Connector implements AccountConnector, TransactionConnector {
  final String hostname;
  final String? port;
  late final SecuredRestClient restClient;
  Connector(this.hostname, this.port) {
    restClient = SecuredRestClient(baseUrl: hostname, port: port);
  }

  Future<InitialPullData> getInitialData(AccountVault accountVault);

  Future<RestClient> logIn(String username, String email);

  Future<void> logOut();
}
