import 'package:cashcompass_hook/src/accounts/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account.dart';
import 'package:cashcompass_hook/src/factories/account_factory.dart';
import 'package:cashcompass_hook/src/factories/transaction_factory.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

class Factory
    implements
        TransactionFactory<Map<String, dynamic>>,
        AccountFactory<Map<String, dynamic>> {
  @override
  Future<Transaction> createTransaction(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<ActiveAcount> getActiveAccount(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Category> getCategory(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<PassiveAccount> getPassiveAccount(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}
