import 'dart:io';

import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class RemoteStorage implements DataAdapter {
  RestClient _client;
  RemoteStorage(this._client);
  @override
  Future<InitialPullData> getInitialPull() {
    // TODO: implement getInitialPull
    throw UnimplementedError();
  }

  @override
  Future<T> load<T extends Factory>(EntityPaths path, id) {
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
