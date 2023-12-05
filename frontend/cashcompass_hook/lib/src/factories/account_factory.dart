import 'package:cashcompass_hook/src/accounts/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account.dart';

// Generic, that we can adjust the incomming type

abstract class AccountFactory<IncommingDataAccount, IncommingDataCategory> {
  Future<ActiveAcount> getActiveAccount(IncommingDataAccount data);
  Future<PassiveAccount> getPassiveAccount(IncommingDataAccount data);
  Future<Category> getCategory(IncommingDataCategory data);
}
