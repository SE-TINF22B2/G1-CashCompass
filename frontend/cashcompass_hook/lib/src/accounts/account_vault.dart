import 'package:cashcompass_hook/src/connector/connector.dart';

abstract class AccountVault {
  final Connector connector;
  AccountVault({required this.connector});
  Future<void> syncToDb() async {}
}
