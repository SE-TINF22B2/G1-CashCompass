import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/data_storage/accoutmanager.dart';
import 'package:test/test.dart';

void main() {
  group("Hook startup", () {
    test('Init mock connector', () {});

    test('Init Account Vault', () {
      Accountmanager();
    });
  });

  group("Mock connector", () {
    test('Init Mock connector', () {});
  });
}
