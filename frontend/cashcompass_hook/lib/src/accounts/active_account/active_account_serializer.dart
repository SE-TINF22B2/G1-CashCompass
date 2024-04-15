import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/bookable_serialiser.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class ActiveAccountSerializer extends Serializer<ActiveAcount>
    with BaseBookableSerializer, BaseDatabaseObjSerialiser {
  ActiveAccountSerializer(super.obj);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = <String, dynamic>{};
    serialiseBaseAccount(ret, obj);
    serialiseDbObj(ret, obj);
    return ret;
  }
}
