import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';

/// The classes in this file are supposed to be used for any object which lies on a database.
/// This means that any object, which enherits [DatabaseObject] needs to implement and use these implemented classes as generics in the [DatabaseObject] definition.

/// Serializers are used for serializing objects in the app for storing it on the devide or sending it to the servers
abstract class Serializer<DatabaseObject> {
  DatabaseObject obj;
  Serializer(this.obj);

  Map<String, dynamic> toJson();
}

/// Factories are used for creating objects from a serialized dataset from the locale storage or the server
/// This factory follows the builder pattern (I know, naming could be better).
/// This means that each child-class of [Factory] needs to implement at least one function for each option to create such an object.
/// For example: one function for decoding from a json and another function for creating a new object.
abstract class Factory<
    T extends DatabaseObject<T, S, F, U>,
    S extends Serializer<T>,
    F extends Factory<T, S, F, U>,
    U extends Updater<T>> {
  final Accountmanager accountManager;
  T? obj;
  Factory(this.accountManager);

  deserialise(
      {required Map<String, dynamic> data, bool isRemote = false, String? id});

  /// Before [build] is called, some function must have had created an obj. and if this object does not have an id (it is completely new), a new one gets assigned.
  T build() {
    if (obj == null) {
      throw Exception("Factory must call a creation");
    }
    if (!obj!.isIdSet) {
      obj!.localId = accountManager.nextUuid;
    }
    return obj!;
  }

  /// Helper functions for parsing a list of [String] from a json.
  List<String> parseDynamicListToStringList(List<dynamic> l) {
    return l.map((e) => e.toString()).toList();
  }
}

/// The [Updater] class is for now only a dummy class, but originally this class should be responsible to make requests in runtime,
/// which are more compllicated than storing and reading values from the database. -> Realtime updates.
abstract class Updater<DataBaseObject> {
  final Serializer connector;
  Updater(this.connector);
}

/// This is the main class for each Databaseobject. As we can see, for each [DatabaseObject], one [Serializer], one [Factory] and an [Updater] must be implemented.
///
mixin DatabaseObject<
    T extends DatabaseObject<T, S, F, U>,
    S extends Serializer<T>,
    F extends Factory<T, S, F, U>,
    U extends Updater<T>> {
  /// Get an Serializer for one object.
  S getSerialiser();

  /// Get a path which identifies the type of this object. See [EntityPaths].
  String getPath();
  String? _id;

  /// Following lines differentiate between the states uploaded and not uploaded, while not uploaded objects can have a changing id.
  /// The id can only change in case of a id collision on the database.
  bool get isIdSet => _id != null || _localId != null;
  set localId(String id) {
    this._localId = id;
  }

  set remoteId(String id) {
    this._id = id;
  }

  // this id can change, when a object gets uploaded to the server. Can cause problems lol. But i guess i need to figure this out later. Access this field after checking if its is uploaded or not.
  String get id => _id ?? _localId!;
  String? _localId;
  String? locale;
  bool get isUploaded => _id != null;
}
