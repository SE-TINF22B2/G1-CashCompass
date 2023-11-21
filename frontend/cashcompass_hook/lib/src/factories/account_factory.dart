import 'package:cashcompass_hook/src/accounts/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account.dart';

// Generic, that we can adjust the incomming type

abstract class AccountFactory<IncommingData> {
  Future<ActiveAcount> getActiveAccount(IncommingData data);
  Future<PassiveAccount> getPassiveAccount(IncommingData data);
  Future<Category> getCategory(IncommingData data);
}
