import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

/// This class represents all Account related data conneted to the initial pull of data.
class InitialPullData {
  // All accounts which are not friendaccount or categories
  List<PassiveAccount> passiveAccounts;
  List<ActiveAcount> activeAccounts;
  List<Transaction> transactions;
  List<Category> categories;
  List<RecurringTransactions> recurringTransactions;

  InitialPullData(
      {required this.recurringTransactions,
      required this.activeAccounts,
      required this.passiveAccounts,
      required this.transactions,
      required this.categories});
}
