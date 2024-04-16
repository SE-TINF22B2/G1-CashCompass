import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_serializer.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_updater.dart';
import 'package:cashcompass_hook/src/accounts/two_step_factory.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class ActiveAccountFactory extends Factory<ActiveAcount,
        ActiveAccountSerializer, ActiveAccountFactory, ActiveAccountUpdater>
    with BaseAccountTwoSetDeserialiserFactory, DataclassDeserialiser
    implements TwoStepDesserialisationFactory {
  ActiveAccountFactory(super.accountManager);
  late List<String> soll, haben;
  ActiveAccountFactory create(String name) {
    obj = ActiveAcount(name, accountManager.nextAccountNumber);
    return this;
  }

  @override
  firstStep() {}

  @override
  secondStep() {
    appendTransactions(obj!, soll, haben, accountManager);
  }

  @override
  ActiveAccountFactory deserialise(
      {required Map<String, dynamic> data, bool isRemote = false, String? id}) {
    obj = ActiveAcount(data["name"], data["account_number"]);
    soll = data["soll"];
    haben = data["haben"];
    deserialiseDbObj(id ?? data["id"], !isRemote);
    return this;
  }
}
