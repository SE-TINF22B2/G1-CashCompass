import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/connector/mock_classes/mock_data_adapter.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';

class MockTransactions {
  static generateTransactions() {
    Accountmanager manager = Accountmanager(dataAdapter: MockDataAdapter());
    var fac = TransactionsFactory(manager);
    return [
      fac
          .create(
              amount: 100.00,
              soll: Category("Geschenk", 1, "#666666", "GiftsDonations"),
              haben: ActiveAccount("ING", 2),
              label: "Geschenk")
          .build(),
      fac
          .create(
              amount: 6.50,
              soll: ActiveAccount("Sparkasse", 3),
              haben: Category("Food", 4, "#666666", "Groceries"),
              label: "Döner")
          .build(),
      fac
          .create(
              amount: 25.00,
              soll: ActiveAccount("ING", 5),
              haben: Category("Mobilität", 6, "#666666", "Transport"),
              label: "Fahrtkosten für Rudi")
          .build(),
      fac
          .create(
              amount: 50.00,
              soll: Category("Geschenk", 7, "#666666", "GiftsDonations"),
              haben: ActiveAccount("BAR", 8),
              label: "Putzen bei Omi")
          .build(),
      fac
          .create(
              amount: 450.00,
              soll: Category("Arbeit", 9, "#666666", "Loans"),
              haben: ActiveAccount("ING", 10),
              label: "Gehalt")
          .build(),
    ];
  }
}
