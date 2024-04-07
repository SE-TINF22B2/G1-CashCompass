import 'package:cashcompass_hook/src/accounts/passive_account.dart';

class Category extends PassiveAccount {
  late String _color;
  Category(super.name, super.accountNumber, String color) {
    _color = color;
  }

  String get colorString => _color;
}
