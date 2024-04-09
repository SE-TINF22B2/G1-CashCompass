import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

class TransactionsFactory extends Factory<Transaction> {
  TransactionsFactory(super.connector);

  @override
  DatabaseObject<dynamic, Serializer, Factory, Updater> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
