import 'package:cashcompass_hook/src/accounts/bookable.dart';

class PassiveAccount with Bookable {
  PassiveAccount(String name, int accountNumber) {
    this.name = name;
    this.accountNumber = accountNumber;
  }

  @override
  double close() {
    return getHabenAmount() - getSollAmount();
  }
}
