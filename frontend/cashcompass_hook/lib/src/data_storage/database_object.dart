import 'package:cashcompass_hook/src/connector/connector.dart';

/// Serializers are used for serializing objects in the app for storing it on the devide or sending it to the servers
abstract class Serializer<DatabaseObject> {
  DatabaseObject obj;
  Serializer(this.obj);

  Map<String, dynamic> toJson();
}

/// Factories are used for creating objects from a serialized dataset from the locale storage or the server
abstract class Factory<DataBaseObject> {
  final Serializer connector;
  Factory(this.connector);

  DatabaseObject build();
}

/// These requests are used for
abstract class Updater<DataBaseObject> {
  final Serializer connector;
  Updater(this.connector);
}

mixin DatabaseObject<T, S extends Serializer<T>, F extends Factory<T>,
    U extends Updater<T>> {
  S getSerialiser();
  String? id;
  bool get isUploaded => id != null;
}
