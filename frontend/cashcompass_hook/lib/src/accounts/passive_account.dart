import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/currency/currency.dart';

class PassiveAccount with Bookable {
  PassiveAccount(String name, int accountNumber) {
    this.name = name;
    this.accountNumber = accountNumber;
  }

  @override
  Currency close() {
    return getHabenAmount() - getSollAmount();
  }
}
