// Two step factory is used for the creation of accounts and transactions. The trick is to first create every transaction AND account and after that linking them together. 
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/data_storage/accoutmanager.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

abstract class TwoStepDesserialisationFactory {
  deserialise(Map<String, dynamic> data);
  firstStep();
  secondStep();
}

mixin BaseAccountTwoSetDeserialiserFactory<
    T extends DatabaseObject<T, S, F, U>,
    S extends Serializer<T>,
    F extends Factory<T, S, F, U>,
    U extends Updater<T>> on Factory<T, S, F, U> {
  appendTransactions(Bookable obj, List<String> soll, List<String> haben,
      Accountmanager accountManager) {
    obj.appendTransactions(soll.map((e) {
      var r = accountManager.getTransactionById(e);
      if (r == null) {
        throw Exception("Cannot find transaction!");
      }
      return r;
    }));
  }
}
