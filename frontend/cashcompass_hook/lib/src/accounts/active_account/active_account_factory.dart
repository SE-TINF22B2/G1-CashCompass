import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class ActiveAccountFactory extends Factory<ActiveAcount> {
  ActiveAccountFactory(super.connector);

  @override
  DatabaseObject<ActiveAcount, Serializer, Factory, Updater> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
