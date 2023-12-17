import 'package:cashcompass_hook/cashcompass_hook.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/connector/impl/mock_connector.dart';
import 'package:test/test.dart';

void main() {
  Connector connector = MockConnector();
  group("Hook startup", () {
    test('Init mock connector', () {});

    test('Init Account Vault', () {
      AccountVault(connector: connector);
    });
  });

  group("Mock connector", () {
    test('Init Mock connector', () {
      Connector mockconnector = MockConnector();
      mockconnector.getInitialData();
    });
  });
}
