import 'package:cashcompass_hook/src/accounts/bookable_serialiser.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';

class RecurringTransactionsSerializer extends Serializer<RecurringTransactions>
    with BaseDatabaseObjSerialiser {
  RecurringTransactionsSerializer(super.obj);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {
      "soll": obj.soll.accountNumber,
      "haben": obj.haben.accountNumber,
      "amount": obj.amount,
      "start": obj.startDate.toIso8601String(),
      "end": obj.endDate.toIso8601String(),
      "interval": obj.interval.toString()
    };
    serialiseDbObj(ret, obj);
    return ret;
  }
}
