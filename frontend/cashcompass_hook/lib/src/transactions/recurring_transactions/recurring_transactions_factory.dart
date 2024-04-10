import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_serializer.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_updater.dart';

class RecurringTransactionsFactory extends Factory<RecurringTransactions> {
  RecurringTransactionsFactory(super.connector);

  @override
  DatabaseObject<RecurringTransactions, RecurringTransactionsSerializer,
      RecurringTransactionsFactory, RecurringTransactionsUpdater> build() {
    throw UnimplementedError();
  }
}
