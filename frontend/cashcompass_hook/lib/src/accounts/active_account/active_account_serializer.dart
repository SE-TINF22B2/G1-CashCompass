import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class ActiveAccountSerializer extends Serializer<ActiveAcount> {
  ActiveAccountSerializer(super.obj);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
