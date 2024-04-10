import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class LocaleStorage implements DataAdapter {
  @override
  Future<InitialPullData> getInitialPull() {
    // TODO: implement getInitialPull
    throw UnimplementedError();
  }

  @override
  Future<T> load<T extends Factory>(EntityPaths path, String id, T factory) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future store(DatabaseObject obj) {
    // TODO: implement store
    throw UnimplementedError();
  }
}
