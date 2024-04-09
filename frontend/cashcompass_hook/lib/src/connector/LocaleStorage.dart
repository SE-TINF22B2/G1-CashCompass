import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class LocaleStorage implements DataAdapter {
  @override
  Future<InitialPullData> getInitialPull() {
    // TODO: implement getInitialPull
    throw UnimplementedError();
  }

  @override
  Future<T> load<T extends Factory>(String path, id) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future store(
      String path, DatabaseObject<dynamic, Serializer, Factory, Updater> obj) {
    // TODO: implement store
    throw UnimplementedError();
  }
}
