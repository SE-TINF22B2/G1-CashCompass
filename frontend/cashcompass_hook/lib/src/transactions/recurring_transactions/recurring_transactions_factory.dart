import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_serializer.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_updater.dart';

class RecurringTransactionsFactory extends Factory<
    RecurringTransactions,
    RecurringTransactionsSerializer,
    RecurringTransactionsFactory,
    RecurringTransactionsUpdater> {
  RecurringTransactionsFactory(super.accountManager);

  create(
      {required double amount,
      required DateTime startDate,
      required DateTime endDate,
      required Duration interval,
      required Bookable soll,
      required Bookable haben}) {
    obj = RecurringTransactions(
        amount: amount,
        endDate: endDate,
        startDate: startDate,
        haben: haben,
        interval: interval,
        soll: soll);
  }
}
