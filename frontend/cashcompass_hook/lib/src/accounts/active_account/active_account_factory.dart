import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_serializer.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_updater.dart';
import 'package:cashcompass_hook/src/accounts/two_step_factory.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class ActiveAccountFactory extends Factory<ActiveAcount,
        ActiveAccountSerializer, ActiveAccountFactory, ActiveAccountUpdater>
    with BaseAccountTwoSetDeserialiserFactory
    implements TwoStepDesserialisationFactory {
  ActiveAccountFactory(super.accountManager);
  late List<String> soll, haben;
  create(String name) {
    obj = ActiveAcount(name, accountManager.nextAccountNumber);
  }

  @override
  firstStep() {}

  @override
  secondStep() {
    appendTransactions(obj!, soll, haben, accountManager);
  }

  @override
  deserialise(Map<String, dynamic> data) {
    obj = ActiveAcount(data["name"], data["account_number"]);
    soll = data["soll"];
    haben = data["haben"];
  }
}
