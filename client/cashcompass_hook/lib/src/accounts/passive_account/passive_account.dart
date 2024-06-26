import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_serializer.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_updater.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/currency/currency.dart';

class PassiveAccount extends RemoteBookable<PassiveAccount,
    PassiveAccountSerializer, PassiveAccountFactory, PassiveAccountUpdater> {
  PassiveAccount(String name, int accountNumber) {
    this.name = name;
    this.accountNumber = accountNumber;
  }

  @override
  Currency close() {
    return getHabenAmount() - getSollAmount();
  }

  @override
  PassiveAccountSerializer getSerialiser() {
    return PassiveAccountSerializer(this);
  }

  @override
  String getPath() {
    return EntityPaths.passiveaccount.path;
  }
}
