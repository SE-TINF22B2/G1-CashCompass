import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

class TransactionsSerializer extends Serializer<Transaction> {
  TransactionsSerializer(super.obj);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
