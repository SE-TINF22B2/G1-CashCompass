import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';

class RecurringTransactionsSerializer
    extends Serializer<RecurringTransactions> {
  RecurringTransactionsSerializer(super.obj);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
