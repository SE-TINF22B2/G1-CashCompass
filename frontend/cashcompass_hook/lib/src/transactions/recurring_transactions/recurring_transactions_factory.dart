import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';

class RecurringTransactionsFactory extends Factory<RecurringTransactions> {
  RecurringTransactionsFactory(super.connector);

  @override
  DatabaseObject<dynamic, Serializer, Factory, Updater> build() {
    throw UnimplementedError();
  }
}
