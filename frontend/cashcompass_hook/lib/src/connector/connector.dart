// one connector reprents the connection to one User's data.
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/LocaleStorage.dart';
import 'package:cashcompass_hook/src/connector/remote_storage.dart';
import 'package:cashcompass_hook/src/connector/secured_rest_client.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class Serialiser implements DataAdapter {
  late LocaleStorage _localStorage;
  late RemoteStorage _remoteStorage;
  Serialiser({required SecuredRestClient httpClient}) {
    _localStorage = LocaleStorage();
    _remoteStorage = RemoteStorage(httpClient);
  }

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

abstract class DataAdapter {
  Future<InitialPullData> getInitialPull();

  Future store(String path, DatabaseObject obj);
  Future<T> load<T extends Factory>(String path, id);
}
