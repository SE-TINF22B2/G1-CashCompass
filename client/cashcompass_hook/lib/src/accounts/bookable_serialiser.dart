import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

mixin BaseBookableSerializer {
  void serialiseBaseAccount(Map<String, dynamic> map, Bookable book) {
    map.addAll({
      "name": book.name,
      "account_number": book.accountNumber,
      "soll": book.sollT.map((e) => e.id).toList(),
      "haben": book.habenT.map((e) => e.id).toList()
    });
  }
}

mixin BaseDatabaseObjSerialiser {
  void serialiseDbObj(Map<String, dynamic> map, DatabaseObject obj) {
    map.addAll({"id": obj.id, "isUploaded": obj.isUploaded});
  }
}
