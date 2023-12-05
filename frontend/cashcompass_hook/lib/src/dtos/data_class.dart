import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';

abstract class DataClass<T extends BaseDTO> {
  /// IMPORTANT: CONTRUCTOR NEEDS TO INITALISE THE DTO
  late T _dto; // TODO yeah idk how i can fix this
  T get dto => _dto;
  bool get isUploaded => dto.isUploaded;
  Future<T> getDTO(Connector connector);

  setDTO(T t) {
    _dto = t;
    if (!dto.isUploaded) {
      dto.upload();
    }
  }

  DataClass({required T? dto}) {
    if (dto != null) {
      setDTO(dto);
    }
  }
}
