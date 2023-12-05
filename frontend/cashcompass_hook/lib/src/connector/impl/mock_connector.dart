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
  List<MockAccount> activeAccounts = [
    MockAccount(id: "1", name: "Bank", accountNumber: 1),
    MockAccount(id: "2", name: "Bar", accountNumber: 2),
    MockAccount(id: "3", name: "Ich hab keine Ahnung", accountNumber: 3)
  ];
  List<MockAccount> passiveAccounts = [];
  List<MockCategory> categories = [];
  List<MockTransaction> transactions = [];
  List<MockRecurringTransactions> recurringTransactions = [];
  List<MockAccount> get accounts =>
      activeAccounts + passiveAccounts + categories;
  MockConnector() : super("", "") {
    activeAccounts.addAll([
      MockAccount(
          id: getUUID(), name: "John Doe's Checking Account", accountNumber: 1),
      MockAccount(
          id: getUUID(), name: "John Doe's Savings Account", accountNumber: 2),
      MockAccount(
          id: getUUID(), name: "John Doe's Personal Loan", accountNumber: 4),
      MockAccount(
          id: getUUID(), name: "Jane Doe's Checking Account", accountNumber: 6),
      MockAccount(id: getUUID(), name: "Jane's Bakery", accountNumber: 8),
      MockAccount(
          id: getUUID(), name: "Jane Doe's Credit Card", accountNumber: 10)
    ]);
    passiveAccounts.addAll([
      MockAccount(id: getUUID(), name: "John's Diner", accountNumber: 3),
      MockAccount(
          id: getUUID(), name: "Jane Doe's Savings Account", accountNumber: 7),
      MockAccount(
          id: getUUID(), name: "Jane Doe's Personal Loan", accountNumber: 9),
      MockAccount(
          id: getUUID(), name: "John Doe's Credit Card", accountNumber: 5),
    ]);
    transactions.addAll([
      MockTransaction(
          transactionNumber: 1,
          id: getUUID(),
          amount: 100.0,
          habenAccNr: 1,
          sollAccNr: 3,
          timestamp: DateTime(2022, 02, 01)),
      MockTransaction(
          transactionNumber: 2,
          id: getUUID(),
          amount: 200.0,
          habenAccNr: 7,
          sollAccNr: 1,
          timestamp: DateTime(2022, 02, 02)),
      MockTransaction(
          transactionNumber: 3,
          id: getUUID(),
          amount: 150.0,
          habenAccNr: 1,
          sollAccNr: 2,
          timestamp: DateTime(2022, 02, 03)),
      MockTransaction(
          transactionNumber: 4,
          id: getUUID(),
          amount: 75.0,
          habenAccNr: 2,
          sollAccNr: 1,
          timestamp: DateTime(2022, 02, 04)),
      MockTransaction(
          transactionNumber: 5,
          id: getUUID(),
          amount: 300.0,
          habenAccNr: 1,
          sollAccNr: 2,
          timestamp: DateTime(2022, 02, 05)),
      MockTransaction(
          transactionNumber: 6,
          id: getUUID(),
          amount: 50.0,
          habenAccNr: 2,
          sollAccNr: 1,
          timestamp: DateTime(2022, 02, 06))
    ]);
  }

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
  Future<InitialPullData> getInitialData() async {
    AccountVault accountVault = AccountVault(connector: this);

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
    var categoriesF = Future.wait(categories.map((e) => fac.getCategory(e)));

    await Future.wait([
      activeAccountsF.then((value) => active = value),
      passiveAccountsF.then((value) => passive = value),
      categoriesF.then((value) => catego = value),
    ]);
    accountVault.addAccounts(active);
    accountVault.addAccounts(passive);
    accountVault.addCategories(catego);
    var transactionsF =
        Future.wait(this.transactions.map((e) => fac.getTransaction(e)));
    var recurringTransactionsF = Future.wait(
        recurringTransactions.map((e) => fac.createRecurringTransaction(e)));
    await Future.wait([
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
        habenAccNr: haben.accountNumber,
        sollAccNr: soll.accountNumber,
        timestamp: timestamp,
        transactionNumber: transactionNumber);
    return Future.value(x.id);
  }
}
