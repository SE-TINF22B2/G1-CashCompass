import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';

abstract class DataClass<T extends BaseDTO> {
  /// IMPORTANT: CONTRUCTOR NEEDS TO INITALISE THE DTO
  late T _dto;
  T get dto => _dto;
  bool get isUploaded => dto.isUploaded;
  Future<T> getDTO(Connector connector);
  DataClass({required T dto}) {
    _dto = dto;
    if (!dto.isUploaded) {
      dto.upload();
    }
  }
}
