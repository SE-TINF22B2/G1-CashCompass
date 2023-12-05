import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';

class CategoryDTO extends AccountDTO {
  @override
  Category get data => super.data as Category;
  @override
  CategoryDTO(super.id, Category super.data,
      {required TransactionConnector super.connector})
      : super(isActive: false);
  Future<String> updateColorCode(String colorCode) async {
    return connector.changeCategoryColor(this, colorCode);
  }

  @override
  Future<String> upload() {
    return connector.createAccount(
        name: data.name, accountNumber: data.accountNumber, isActive: false);
  }
}
