import 'package:cashcompass_hook/src/connector/connectorImpl.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/account_connector.dart';

abstract class AccountVault {
  final ConnectorImpl connector;
  AccountVault({required this.connector});
  Future<void> syncToDb() async {}
}
