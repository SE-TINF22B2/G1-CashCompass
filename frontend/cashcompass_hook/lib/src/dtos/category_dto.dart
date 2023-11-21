import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/account_connector.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';

class CategoryDTO extends AccountDTO {
  @override
  Category get data => super.data as Category;
  @override
  AccountConnector get connector => super.connector as AccountConnector;
  CategoryDTO(super.id, Category super.data,
      {required TransactionConnector super.connector});
  Future<String> updateColorCode(String colorCode) async {
    return connector.changeCategoryColor(this, colorCode);
  }
}
