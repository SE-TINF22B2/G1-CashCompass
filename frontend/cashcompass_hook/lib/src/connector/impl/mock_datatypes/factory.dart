import 'package:cashcompass_hook/cashcompass_hook.dart';
import 'package:cashcompass_hook/src/accounts/active_account.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/connector/impl/mock_datatypes/mock_datatypes.dart';
import 'package:cashcompass_hook/src/dtos/account_dto.dart';
import 'package:cashcompass_hook/src/dtos/category_dto.dart';
import 'package:cashcompass_hook/src/dtos/recurring_transaction_dto.dart';
import 'package:cashcompass_hook/src/dtos/transaction_dto.dart';
import 'package:cashcompass_hook/src/factories/account_factory.dart';
import 'package:cashcompass_hook/src/factories/recurringtransations_factory.dart';
import 'package:cashcompass_hook/src/factories/transaction_factory.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

class MockFactory
    implements
        TransactionFactory<MockTransaction>,
        AccountFactory<MockAccount, MockCategory>,
        RecurringTransactionFactory<MockRecurringTransactions> {
  late AccountVault vault;
  late Connector connector;
  MockFactory(this.vault, this.connector);
  @override
  Future<Transaction> getTransaction(MockTransaction data) {
    var transaction = Transaction(
        dto: null,
        transactionNumber: data.transactionNumber,
        soll: vault.getAccount(data.sollAccNr)!,
        haben: vault.getAccount(data.habenAccNr)!,
        amount: data.amount);

    var dto = TransactionDTO(data.id, transaction, connector: connector);
    transaction.setDTO(dto);
    return Future.value(transaction);
  }

  @override
  Future<ActiveAcount> getActiveAccount(MockAccount data) {
    var account = ActiveAcount(data.name, data.accountNumber);
    var dto =
        AccountDTO(data.id, account, connector: connector, isActive: true);
    //account.setDTO(dto);
    return Future.value(account);
  }

  @override
  Future<Category> getCategory(MockCategory data) {
    var cat = Category(data.name, data.accountNumber, data.color);
    var dto = CategoryDTO(data.id, cat, connector: connector);
    return Future.value(cat);
  }

  @override
  Future<PassiveAccount> getPassiveAccount(MockAccount data) {
    var account = PassiveAccount(data.name, data.accountNumber);
    var dto =
        AccountDTO(data.id, account, connector: connector, isActive: false);
    return Future.value(account);
  }

  @override
  Future<RecurringTransactions> createRecurringTransaction(
      MockRecurringTransactions data) async {
    Bookable soll = vault.getAccountById(data.sollId);
    Bookable haben = vault.getAccountById(data.habenId);
    var reccuringTransction = RecurringTransactions(
        dto: null,
        amount: data.amount,
        startDate: data.start,
        endDate: data.end,
        interval: data.intervall,
        soll: soll,
        haben: haben);
    var dto = RecurringTransactionDTO(data.id, reccuringTransction,
        connector: connector);
    reccuringTransction.setDTO(dto);
    return reccuringTransction;
  }
}
