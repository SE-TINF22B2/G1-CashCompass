import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/data_storage/datastorage.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

class Accountmanager {
  //final Connector connector;
  final Datastorage _data = Datastorage();
  Future<void> init() async {}

  int get nextAccountNumber => _data.getNewAccountNumber();
  int get nextTransactionNumber => _data.getNewTransactionNumber();

  Bookable? getAccount(int accountNr) {
    // ignore: unnecessary_cast
    return (_data.allRemoteAccounts as List<Bookable?>).firstWhere(
        (element) => element != null && element.accountNumber == accountNr,
        // ignore: unnecessary_cast
        orElse: () => (_data.categories as List<Bookable?>).firstWhere(
            (element) => element != null && element.accountNumber == accountNr,
            orElse: () => null));
  }

  Bookable getAccountById(String id) {
    return _data.allRemoteAccounts.firstWhere((element) => element.id == id,
        orElse: () =>
            _data.categories.firstWhere((element) => element.id == id));
  }

  Transaction? getTransactionById(String id) {
    // ignore: unnecessary_cast
    return (_data.transactions as Iterable<Transaction?>)
        .firstWhere((element) => element?.id == id);
  }

  void addActiveAccounts(Iterable<ActiveAcount> acc) {
    _data.activeAccounts.addAll(acc);
  }

  void addPassiveAccounts(Iterable<PassiveAccount> acc) {
    _data.passiveAccounts.addAll(acc);
  }

  void addCategories(List<Category> categories) {
    _data.categories.addAll(categories);
  }
}
