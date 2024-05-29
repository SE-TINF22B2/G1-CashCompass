import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/data.dart';
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

  Map<Category, Iterable<Expense>> getExpencesPerCategory(Category? category) {
    Map<Category, Iterable<Expense>> ret = {};
    Iterable<Category> categories = _accountmanager
        .getAllCategories()
        .where((cate) => category == null ? true : cate == category);

    for (var category in categories) {
      var e = category.sollT.map((elem) => Expense(elem, category));
      if (e.isNotEmpty) {
        ret[category] = e;
      }
    }
    return ret;
  }

  Map<Category, Iterable<Income>> getIncomePerCategory(Category? category) {
    Map<Category, Iterable<Income>> ret = {};
    Iterable<Category> categories = _accountmanager
        .getAllCategories()
        .where((cate) => category == null ? true : cate == category);

    for (var category in categories) {
      var e = category.sollT.map((elem) => Income(elem, category));
      if (e.isNotEmpty) {
        ret[category] = e;
      }
    }
    return ret;
  }

  List<TransactionInfo> getAllTransactionsRealtedToCategories() {
    List<TransactionInfo> ret = [];
    ret.addAll(_accountmanager.getAllCategories().expand((cate) => cate.habenT
        .map((transaction) =>
            TransactionInfo(TransactionTypes.expense, transaction, cate))));

    ret.addAll(_accountmanager.getAllCategories().expand((cate) => cate.sollT
        .map((transaction) =>
            TransactionInfo(TransactionTypes.income, transaction, cate))));
    return ret;
  }

  List<ActiveAccount> getActiveAccounts(
      {bool Function(ActiveAccount)? matcher}) {
    return _accountmanager
        .getAllActiveAccounts()
        .where((acc) => matcher != null ? matcher(acc) : true)
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
