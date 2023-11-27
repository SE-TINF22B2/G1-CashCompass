import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

/// This class represents all Account related data conneted to the initial pull of data.
class InitialPullData {
  List<RecurringTransactions> recurringTransactions;

  // All accounts which are not friendaccount or categories
  List<Account> accounts;
  List<Transaction> transactions;
  List<Category> categories;

  InitialPullData(
      {required this.recurringTransactions,
      required this.accounts,
      required this.transactions,
      required this.categories});
}
