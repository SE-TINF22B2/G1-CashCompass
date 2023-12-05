import 'package:cashcompass_hook/cashcompass_hook.dart';
import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/accounts/active_account.dart';
import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/accounts/passive_account.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/connector/impl/mock_datatypes/factory.dart';
import 'package:cashcompass_hook/src/connector/impl/mock_datatypes/mock_datatypes.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';
import 'package:uuid/uuid.dart' show Uuid;

const uuid = Uuid();

class MockConnector extends Connector {
  List<MockAccount> activeAccounts = [];
  List<MockAccount> passiveAccounts = [];
  List<MockCategory> categories = [];
  List<MockTransaction> transactions = [];
  List<MockRecurringTransactions> recurringTransactions = [];
  List<MockAccount> get accounts =>
      activeAccounts + passiveAccounts + categories;
  MockConnector() : super("", "");

  String getUUID() {
    return uuid.v6();
  }

  @override
  Future<String> changeAccountName(AccountDTO account, String newName) {
    var acc = accounts.firstWhere((element) => element.id == account.id);
    acc.name = newName;
    return Future.value(newName);
  }

  @override
  Future<String> changeCategoryColor(AccountDTO account, String colorCode) {
    var cat = categories.firstWhere((element) => element.id == account.id);
    cat.color = colorCode;
    return Future.value(colorCode);
  }

  @override
  Future<double> changeRecurringTransactionAmount(
      RecurringTransactions recurringTransaction, double newAmount) {
    var col = recurringTransactions
        .firstWhere((element) => element.id == recurringTransaction.dto.id);
    col.amount = newAmount;
    return Future.value(newAmount);
  }

  @override
  Future<double> changeTransactionAmount(
      Transaction transaction, double newAmount) {
    var tra =
        transactions.firstWhere((element) => element.id == transaction.dto.id);
    tra.amount = newAmount;
    return Future.value(newAmount);
  }

  @override
  Future<String> createRecurringTransaction(
      {required Account soll,
      required Account haben,
      required double amount,
      required DateTime startTimestamp,
      required DateTime endTimestamp,
      required Duration interval}) {
    var x = MockRecurringTransactions(
        id: getUUID(),
        sollId: soll.dto.id,
        habenId: haben.dto.id,
        amount: amount,
        end: endTimestamp,
        intervall: interval,
        start: startTimestamp);
    recurringTransactions.add(x);
    return Future.value(x.id);
  }

  @override
  Future<InitialPullData> getInitialData(AccountVault accountVault) async {
    var fac = MockFactory(accountVault, this);
    late List<ActiveAcount> active;
    late List<PassiveAccount> passive;
    late List<Category> catego;
    late List<RecurringTransactions> recurrintTransactions;
    late List<Transaction> transactions;
    var activeAccountsF =
        Future.wait(activeAccounts.map((e) => fac.getActiveAccount(e)));
    var passiveAccountsF =
        Future.wait(passiveAccounts.map((e) => fac.getPassiveAccount(e)));
    var recurringTransactionsF = Future.wait(
        recurringTransactions.map((e) => fac.createRecurringTransaction(e)));
    var categoriesF = Future.wait(categories.map((e) => fac.getCategory(e)));
    var transactionsF =
        Future.wait(this.transactions.map((e) => fac.getTransaction(e)));

    await Future.wait([
      activeAccountsF.then((value) => active = value),
      passiveAccountsF.then((value) => passive = value),
      categoriesF.then((value) => catego = value),
      recurringTransactionsF.then((value) => recurrintTransactions = value),
      transactionsF.then((value) => transactions = value)
    ]);
    return InitialPullData(
        recurringTransactions: recurrintTransactions,
        activeAccounts: active,
        transactions: transactions,
        categories: catego,
        passiveAccounts: passive);
  }

  @override
  Future<RestClient> logIn(String username, String email) {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    throw UnimplementedError();
  }

  @override
  Future<String> createAccount(
      {required String name,
      required int accountNumber,
      required bool isActive}) {
    var newA =
        MockAccount(id: getUUID(), name: name, accountNumber: accountNumber);
    if (isActive) {
      activeAccounts.add(newA);
    } else {
      passiveAccounts.add(newA);
    }
    return Future.value(newA.id);
  }

  @override
  Future<String> createTransaction(
      {required Account soll,
      required Account haben,
      required double amount,
      required DateTime timestamp,
      required int transactionNumber}) {
    var x = MockTransaction(
        id: getUUID(),
        amount: amount,
        habenId: haben.dto.id,
        sollId: soll.dto.id,
        timestamp: timestamp,
        transactionNumer: transactionNumber);
    return Future.value(x.id);
  }
}
