import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

class ConnectorImpl extends Connector {
  ConnectorImpl(super.hostname, super.port);

  @override
  Future<String> changeAccountName(AccountDTO account, String newName) {
    // TODO: implement changeAccountName
    throw UnimplementedError();
  }

  @override
  Future<String> changeCategoryColor(AccountDTO account, String colorCode) {
    // TODO: implement changeCategoryColor
    throw UnimplementedError();
  }

  @override
  Future<double> changeRecurringTransactionAmount(
      RecurringTransactions recurringTransactions, double newAmount) {
    // TODO: implement changeRecurringTransactionAmount
    throw UnimplementedError();
  }

  @override
  Future<double> changeTransactionAmount(
      Transaction transaction, double newAmount) {
    // TODO: implement changeTransactionAmount
    throw UnimplementedError();
  }

  @override
  Future<String> createAccount(
      {required String name,
      required int accountNumber,
      required bool isActive}) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<String> createRecurringTransaction(
      {required Bookable soll,
      required Bookable haben,
      required double amount,
      required DateTime startTimestamp,
      required DateTime endTimestamp,
      required Duration interval}) {
    // TODO: implement createRecurringTransaction
    throw UnimplementedError();
  }

  @override
  Future<String> createTransaction(
      {required Bookable soll,
      required Bookable haben,
      required double amount,
      required DateTime timestamp,
      required int transactionNumber}) {
    // TODO: implement createTransaction
    throw UnimplementedError();
  }

  @override
  Future<InitialPullData> getInitialData() {
    // TODO: implement getInitialData
    throw UnimplementedError();
  }

  @override
  Future<RestClient> logIn(String username, String email) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
