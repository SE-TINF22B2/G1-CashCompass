import 'package:cashcompass_hook/src/connector/connectorImpl.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';

abstract class DataClass<T extends BaseDTO> {
  late T _dto;
  T get dto => _dto;
  bool get isUploaded => dto.isUploaded;
  Future<T> getDTO(Connector connector);
}
