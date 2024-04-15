import 'package:cashcompass_hook/src/data_storage/accoutmanager.dart';

/// Serializers are used for serializing objects in the app for storing it on the devide or sending it to the servers
abstract class Serializer<DatabaseObject> {
  DatabaseObject obj;
  Serializer(this.obj);

  Map<String, dynamic> toJson();
}

/// Factories are used for creating objects from a serialized dataset from the locale storage or the server
abstract class Factory<
    T extends DatabaseObject<T, S, F, U>,
    S extends Serializer<T>,
    F extends Factory<T, S, F, U>,
    U extends Updater<T>> {
  final Accountmanager accountManager;
  T? obj;
  Factory(this.accountManager);

  DatabaseObject<T, S, F, U> build() {
    if (obj == null) {
      throw Exception("Factory must call a creation");
    }
    return obj!;
  }
}

/// These requests are used for
abstract class Updater<DataBaseObject> {
  final Serializer connector;
  Updater(this.connector);
}

mixin DatabaseObject<
    T extends DatabaseObject<T, S, F, U>,
    S extends Serializer<T>,
    F extends Factory<T, S, F, U>,
    U extends Updater<T>> {
  S getSerialiser();
  String getPath();
  String? id;
  bool get isUploaded => id != null;
}
