import 'package:cashcompass_hook/src/accounts/bookable_serialiser.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class PassiveAccountSerializer extends Serializer<PassiveAccount>
    with BaseBookableSerializer, BaseDatabaseObjSerialiser {
  PassiveAccountSerializer(super.obj);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = <String, dynamic>{};
    serialiseBaseAccount(ret, obj);
    serialiseDbObj(ret, obj);
    return ret;
  }
}
