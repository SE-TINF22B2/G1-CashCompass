import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_serializer.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_updater.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class PassiveAccountFactory extends Factory<PassiveAccount> {
  PassiveAccountFactory(super.connector);

  @override
  DatabaseObject<PassiveAccount, PassiveAccountSerializer,
      PassiveAccountFactory, PassiveAccountUpdater> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
