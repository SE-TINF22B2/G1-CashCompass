import 'package:cashcompass_hook/src/connector/specialized_connectors/connector_spez.dart';
import 'package:cashcompass_hook/src/dtos/data_class.dart';

class BaseDTO {
  String? _id;
  String get id => _id!;
  final DataClass data;
  ConnectorSpez connector;
  BaseDTO(this._id, this.data, {required this.connector});
  bool get isUploaded => _id != null;
}
