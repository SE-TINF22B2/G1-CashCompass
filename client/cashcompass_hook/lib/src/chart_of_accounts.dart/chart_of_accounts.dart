import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';

class ChartOfAccounts {
  final Accountmanager _accountmanager;
  ChartOfAccounts(this._accountmanager);

  List<Category> getCategories({bool Function(Category)? matcher}) {
    return _accountmanager
        .getAllCategories()
        .where((category) => matcher != null ? matcher(category) : true)
        .toList();
  }
}
