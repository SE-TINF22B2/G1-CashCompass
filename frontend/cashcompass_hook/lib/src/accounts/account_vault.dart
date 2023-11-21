import 'package:cashcompass_hook/src/connector/connectorImpl.dart';

abstract class AccountVault {
  final ConnectorImpl connector;
  AccountVault({required this.connector});
  Future<void> syncToDb() async {}
}
