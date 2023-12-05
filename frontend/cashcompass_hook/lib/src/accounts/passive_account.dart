import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';

class PassiveAccount extends Account {
  PassiveAccount(
      {required super.dto, required super.name, required super.accountNumber});

  @override
  double close() {
    return getHabenAmount() - getSollAmount();
  }

  @override
  Future<AccountDTO> getDTO(Connector connector) {
    // TODO: implement getDTO
    throw UnimplementedError();
  }
}
