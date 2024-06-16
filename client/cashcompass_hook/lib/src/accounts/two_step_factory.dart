import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

/// The [TwoStepDesserialisationFactory] is supposed to add the principle of a initialization of the account_manager in two steps. First, adding all accounts and after that lining them all through transactions.
///
/// See [Accountmanager] for an example.
abstract class TwoStepDesserialisationFactory extends Deserializer {
  // This should enable us to create all accounts into the account Manager with the first step and in the second step, every transaction should be injected.
  firstStep();
  secondStep();
}

abstract class Deserializer {
  deserialise(
      {required Map<String, dynamic> data, bool isRemote = false, String? id});
}

/// Collection of deserialization methods for [Bookable] .
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

/// Collection of deserialization methods for [DatabaseObject].
mixin DataclassDeserialiser<
    T extends DatabaseObject<T, S, F, U>,
    S extends Serializer<T>,
    F extends Factory<T, S, F, U>,
    U extends Updater<T>> on Factory<T, S, F, U> {
  deserialiseDbObj(String? id, bool isLocal) {
    if (id == null) {
      throw Exception("An Id must be provided and whether it is local or not");
    }
    if (isLocal) {
      obj!.localId = id;
    } else {
      obj!.remoteId = id;
    }
  }
}
