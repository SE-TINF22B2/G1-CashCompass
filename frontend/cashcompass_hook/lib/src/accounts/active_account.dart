import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/connector_spez.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';

class ActiveAcount extends Account {
  ActiveAcount({required super.name});

  @override
  double close() {
    return getSollAmount() - getHabenAmount();
  }

  @override
  Future<BaseDTO> getDTO(ConnectorSpez connector) {
    // TODO: implement getDTO
    throw UnimplementedError();
  }
}
