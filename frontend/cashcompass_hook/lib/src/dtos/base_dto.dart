import 'dart:developer';

import 'package:cashcompass_hook/src/connector/specialized_connectors/connector_spez.dart';
import 'package:cashcompass_hook/src/dtos/data_class.dart';

abstract class BaseDTO {
  String? _id;
  String get id => _id!;
  final DataClass data;
  ConnectorSpez connector;
  BaseDTO(this._id, this.data, {required this.connector});
  bool get isUploaded => _id != null && _id != "";
  Future<String> upload();
  Future initUpload() async {
    upload().then((value) => _id = value).catchError((error, stackTrace) {
      log("Error while uploading DTO",
          error: error,
          stackTrace: stackTrace,
          name: runtimeType.runtimeType.toString());
      return "";
    });
  }
}
