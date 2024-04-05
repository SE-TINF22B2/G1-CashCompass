import 'package:cashcompass_hook/src/accounts/active_account.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

class AccountVault {
  final Connector connector;
  final List<PassiveAccount> _passiveAccounts = [];
  final List<ActiveAcount> _activeAccounts = [];
  final List<Category> _categories = [];
  final List<Transaction> _transactions = [];
  final List<RecurringTransactions> _recurringTransactions = [];

  List<Bookable> get getAllAccounts {
    var r = <Bookable>[];
    r.addAll(_passiveAccounts);
    r.addAll(_activeAccounts);
    return r;
  }

  Bookable? getAccount(int accountNr) {
    // ignore: unnecessary_cast
    return (getAllAccounts as List<Bookable?>).firstWhere(
        (element) => element!.accountNumber == accountNr,
        orElse: () => null);
  }

  Bookable getAccountById(String id) {
    throw UnimplementedError();
    // return (getAllAccounts as List<Bookable?>).firstWhere(
    //     (element) => element!. == accountNr,
    //     orElse: () => null);
  }

  AccountVault({required this.connector});
  // Future<void> syncToDb() asy;
  Future<void> init() async {}

  void addPassiveAccounts(Iterable<PassiveAccount> accounts) {
    _passiveAccounts.addAll(accounts);
  }

  void addCategories(Iterable<Category> categories) {
    _categories.addAll(categories);
  }

  void addActiveAccounts(Iterable<ActiveAcount> accounts) {
    _activeAccounts.addAll(accounts);
  }
}
