import 'package:cashcompass_hook/src/accounts/bookable_serialiser.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class CategorySerializer extends Serializer<Category>
    with BaseBookableSerializer, BaseDatabaseObjSerialiser {
  CategorySerializer(super.obj);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {};
    serialiseBaseAccount(ret, obj);
    serialiseDbObj(ret, obj);
    ret["color"] = obj.colorString;
    return ret;
  }
}
