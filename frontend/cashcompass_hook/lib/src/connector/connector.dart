// one connector reprents the connection to one User's data.
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/LocaleStorage.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
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

abstract class DataAdapter {
  /*
    get initial data returns all the data from a medium by reading everything and loading it into a InitialPullData object which gets returned from this function.
   */
  Future<InitialPullData> getInitialPull();

  /*
    Stores the overgiven object in the given medium. It is identified by the obj.getPath() and obj.id.
  */
  Future store(DatabaseObject obj);

  /*
    Loads a 
  */
  Future<F> load<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path, String id, F factory);
}
