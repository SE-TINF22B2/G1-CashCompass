import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_serializer.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_updater.dart';
import 'package:cashcompass_hook/src/accounts/two_step_factory.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class ActiveAccountFactory extends Factory<ActiveAccount,
        ActiveAccountSerializer, ActiveAccountFactory, ActiveAccountUpdater>
    with BaseAccountTwoSetDeserialiserFactory, DataclassDeserialiser
    implements TwoStepDesserialisationFactory {
  ActiveAccountFactory(super.accountManager);
  late List<String> soll, haben;
  ActiveAccountFactory create(String name) {
    obj = ActiveAccount(name, accountManager.nextAccountNumber);
    return this;
  }

  @override
  ActiveAccountFactory firstStep() {
    accountManager.addActiveAccounts([obj!]);
    return this;
  }

  @override
  ActiveAccountFactory secondStep() {
    appendTransactions(obj!, soll, haben, accountManager);
    return this;
  }

  @override
  ActiveAccountFactory deserialise(
      {required Map<String, dynamic> data, bool isRemote = false, String? id}) {
    obj = ActiveAccount(data["name"], data["account_number"]);
    soll = parseDynamicListToStringList(data["soll"] ?? []);
    haben = parseDynamicListToStringList(data["haben"] ?? []);
    deserialiseDbObj(id ?? data["id"], !isRemote);
    return this;
  }
}
