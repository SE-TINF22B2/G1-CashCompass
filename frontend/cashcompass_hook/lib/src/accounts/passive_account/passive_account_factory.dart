import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_serializer.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_updater.dart';
import 'package:cashcompass_hook/src/accounts/two_step_factory.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class PassiveAccountFactory extends Factory<PassiveAccount,
        PassiveAccountSerializer, PassiveAccountFactory, PassiveAccountUpdater>
    with BaseAccountTwoSetDeserialiserFactory
    implements TwoStepDesserialisationFactory {
  PassiveAccountFactory(super.accountManager);
  late List<String> soll, haben;
  create(String name) {
    obj = PassiveAccount(name, accountManager.nextAccountNumber);
  }

  @override
  firstStep() {}

  @override
  secondStep() {
    appendTransactions(obj!, soll, haben, accountManager);
  }

  @override
  deserialise(Map<String, dynamic> data) {
    obj = PassiveAccount(data["name"], data["account_number"]);
    soll = data["soll"];
    haben = data["haben"];
  }
}
