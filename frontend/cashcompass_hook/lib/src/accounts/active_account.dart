import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';

class ActiveAcount with Bookable {
  ActiveAcount(String name, int accountNumber) {
    this.accountNumber = accountNumber;
    this.name = name;
  }

  @override
  double close() {
    return getSollAmount() - getHabenAmount();
  }
}
