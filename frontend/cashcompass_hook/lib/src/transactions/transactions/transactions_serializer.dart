import 'package:cashcompass_hook/src/accounts/bookable_serialiser.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';

class TransactionsSerializer extends Serializer<Transaction>
    with BaseDatabaseObjSerialiser {
  TransactionsSerializer(super.obj);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {
      "soll": obj.soll.accountNumber,
      "haben": obj.haben.accountNumber,
      "amount": obj.amount,
      "timestamp": obj.timestamp.toIso8601String(),
      "transactionNumber": obj.transactionNumber
    };
    serialiseDbObj(ret, obj);
    return ret;
  }
}
