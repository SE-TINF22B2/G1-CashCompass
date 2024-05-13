import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class RemoteStorage implements DataAdapter {
  // ignore: unused_field
  final RestClient _client;
  RemoteStorage(this._client);
  @override
  Future<InitialPullData> getInitialPull() {
    // TODO: implement getInitialPull
    throw UnimplementedError();
  }

  @override
  Future<F> load<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path, String id, F factory) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future store(DatabaseObject obj) {
    // TODO: implement store
    throw UnimplementedError();
  }
}
