import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/category/category_factory.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/two_step_factory.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_factory.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';

/// This class represents all Account related data conneted to the initial pull of data.
class InitialPullData {
  // All accounts which are not friendaccount or categories
  List<PassiveAccountFactory> passiveAccounts;
  List<ActiveAccountFactory> activeAccounts;
  List<TransactionsFactory> transactions;
  List<CategoryFactory> categories;
  List<RecurringTransactionsFactory> recurringTransactions;
  DateTime lastsync;

  InitialPullData(
      {required this.recurringTransactions,
      required this.activeAccounts,
      required this.passiveAccounts,
      required this.transactions,
      required this.categories,
      required this.lastsync}) {
    for (TwoStepDesserialisationFactory i in [
      activeAccounts,
      passiveAccounts,
      categories,
      recurringTransactions,
      transactions
    ].expand((x) => x)) {
      i.firstStep();
    }
    for (TwoStepDesserialisationFactory i in [
      activeAccounts,
      passiveAccounts,
      categories,
      recurringTransactions,
      transactions
    ].expand((x) => x)) {
      i.secondStep();
    }
  }
}
