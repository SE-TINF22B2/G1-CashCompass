import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/accounts/account_vault.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/connector/impl/mock_connector.dart';

class CashCompassHook {
  late AccountVault _vault;
  late Connector _connector;
  CashCompassHook({Connector? connector}) {
    connector ?? MockConnector();
    _connector = MockConnector();
    _vault = AccountVault(connector: _connector);
  }

  Iterable<Account> get activeAccounts => _vault.activeAccounts;
  Iterable<Account> get passiveAccounts => _vault.passiveAccounts;
}
