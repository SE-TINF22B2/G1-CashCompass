import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/data_storage/accoutmanager.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';

class MockTransactions {
  static generateTransactions() {
    Accountmanager manager = Accountmanager();
    var fac = TransactionsFactory(manager);
    return [
      fac
          .create(
              amount: 100.00,
              soll: PassiveAccount("Geschenk", 1),
              haben: ActiveAcount("ING", 2))
          .build(),
      fac
          .create(
              amount: 6.50,
              soll: ActiveAcount("Sprakasse", 3),
              haben: PassiveAccount("Food", 4))
          .build(),
      fac
          .create(
              amount: 25.00,
              soll: ActiveAcount("ING", 5),
              haben: PassiveAccount("Mobilität", 6))
          .build(),
      fac
          .create(
              amount: 50.00,
              soll: PassiveAccount("Geschenk", 7),
              haben: ActiveAcount("BAR", 8))
          .build(),
      fac
          .create(
              amount: 450.00,
              soll: PassiveAccount("Arbeit", 9),
              haben: ActiveAcount("ING", 10))
          .build(),
    ];
  }
}
