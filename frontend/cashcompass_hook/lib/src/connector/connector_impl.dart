import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

class ConnectorImpl extends Connector {
  ConnectorImpl(super.hostname, super.port);

  @override
  Future<String> changeAccountName(AccountDTO account, String newName) {
    throw UnimplementedError();
  }

  @override
  Future<double> changeAmount(Transaction transaction, double newAmount) {
    throw UnimplementedError();
  }

  @override
  Future<String> changeCategoryColor(AccountDTO account, String colorCode) {
    throw UnimplementedError();
  }

  @override
  Future<Transaction> createTransaction(
      {required Account soll,
      required Account haben,
      required double amount,
      required DateTime timestamp,
      required int transactionNumber}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> getAllAccounts() {
    throw UnimplementedError();
  }
}
