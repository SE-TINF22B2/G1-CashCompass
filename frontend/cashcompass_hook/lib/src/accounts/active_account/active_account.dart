import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_serializer.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_updater.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/currency/currency.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class ActiveAcount extends RemoteBookable<ActiveAcount, ActiveAccountSerializer,
        ActiveAccountFactory, ActiveAccountUpdater>
    with
        Bookable,
        DatabaseObject<ActiveAcount, ActiveAccountSerializer,
            ActiveAccountFactory, ActiveAccountUpdater> {
  ActiveAcount(String name, int accountNumber) {
    this.accountNumber = accountNumber;
    this.name = name;
  }

  @override
  Currency close() {
    return getSollAmount() - getHabenAmount();
  }

  @override
  ActiveAccountSerializer getSerialiser() {
    return ActiveAccountSerializer(this);
  }
}
