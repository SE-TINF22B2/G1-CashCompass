import 'package:cashcompass_hook/src/connector/specialized_connectors/account_connector.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';

class AccountDTO extends BaseDTO {
  final bool isActive;
  @override
  Account get data => super.data as Account;
  @override
  AccountConnector get connector => super.connector as AccountConnector;
  AccountDTO(super.id, Account super.data,
      {required super.connector, required this.isActive});
  Future<String> changeName(String newName) {
    return connector.changeAccountName(this, newName);
  }

  @override
  Future<String> upload() {
    return connector.createAccount(
        name: data.name, accountNumber: data.accountNumber, isActive: isActive);
  }
}
