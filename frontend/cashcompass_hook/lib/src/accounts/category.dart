import 'package:cashcompass_hook/src/accounts/passive_account.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';

class Category extends PassiveAccount {
  late String _color;
  Category({required super.dto, required super.name, required String color}) {
    _color = color;
  }

  String get colorString => _color;

  @override
  Future<AccountDTO> getDTO(Connector connector) {
    throw UnimplementedError();
  }
}
