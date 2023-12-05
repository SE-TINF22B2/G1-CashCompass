import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

class AccountVault {
  final Connector connector;
  final List<Account> _accounts = [];
  final List<Transaction> _transactions = [];
  final List<Category> _categories = [];
  final List<RecurringTransactions> _recurringTransactions = [];
  Account getAccount(int accountNr) {
    return _accounts.firstWhere((element) => element.accountNumber == accountNr,
        orElse: () => _categories
            .firstWhere((element) => element.accountNumber == accountNr));
  }

  Account getAccountById(String id) {
    return _accounts.firstWhere((element) => element.dto.id == id,
        orElse: () =>
            _categories.firstWhere((element) => element.dto.id == id));
  }

  Iterable<Account> get activeAccounts =>
      _accounts.where((element) => element.isActive);

  Iterable<Account> get passiveAccounts =>
      _accounts.where((element) => !element.isActive);

  AccountVault({required this.connector});
  // Future<void> syncToDb() asy;
  Future<void> init() async {}

  void addAccounts(List<Account> accounts) {
    _accounts.addAll(accounts);
  }

  void addCategories(List<Category> categories) {
    _categories.addAll(categories);
  }
}
