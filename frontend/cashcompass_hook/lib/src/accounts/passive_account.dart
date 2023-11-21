import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/connectorImpl.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';

class PassiveAccount extends Account {
  PassiveAccount({required super.name});

  @override
  double close() {
    return getHabenAmount() - getSollAmount();
  }

  @override
  Future<AccountDTO> getDTO(ConnectorImpl connector) {
    // TODO: implement getDTO
    throw UnimplementedError();
  }
}
