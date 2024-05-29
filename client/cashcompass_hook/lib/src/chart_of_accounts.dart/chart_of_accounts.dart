import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

class CategoryAndTransactions {
  final Category category;
  final List<Transaction> soll, haben;
  CategoryAndTransactions(
      {required this.category, required this.haben, required this.soll});
}

class ChartOfAccounts {
  final Accountmanager _accountmanager;
  ChartOfAccounts(this._accountmanager);

  List<Category> getCategories({bool Function(Category)? matcher}) {
    return _accountmanager
        .getAllCategories()
        .where((category) => matcher != null ? matcher(category) : true)
        .toList();
  }

  List<CategoryAndTransactions> getCategoriesAndTransaktions() {
    var cates = _accountmanager.getAllCategories();
    var ret = <CategoryAndTransactions>[];
    for (Category i in cates) {
      ret.add(
          CategoryAndTransactions(category: i, haben: i.habenT, soll: i.sollT));
    }
    return ret;
  }
}
