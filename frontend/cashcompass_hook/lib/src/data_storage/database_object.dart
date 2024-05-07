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

  T build() {
    if (obj == null) {
      throw Exception("Factory must call a creation");
    }
    if (!obj!.isIdSet) {
      obj!.localId = accountManager.nextUuid;
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
  String? _id;
  bool get isIdSet => _id != null || _localId != null;
  set localId(String id) {
    this._localId = id;
  }

  set remoteId(String id) {
    this._id = id;
  }

  // this id can change, when a object gets uploaded to the server. Can cause problems lol. But i guess i need to figgure this out later. Access this field after checking if its is uploaded or not.
  String get id => _id ?? _localId!;
  String? _localId;
  String? locale;
  bool get isUploaded => _id != null;
}
