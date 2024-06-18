import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_factory.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_factory.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/connector/sync_controller.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/data_storage/datastorage.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_factory.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';
import 'package:uuid/uuid.dart';

class Accountmanager {
  //final Connector connector;
  final Datastorage _data = Datastorage();
  final Uuid _uuid = const Uuid();
  late final DataAdapter _dataAdapter;
  Accountmanager({required DataAdapter dataAdapter}) {
    _dataAdapter = dataAdapter;
  }
  Future<void> init() async {
    var initialData = await _dataAdapter.getInitialPull(this);
    // Iterable<ActiveAccountFactory> activeFac = initialData.activeAccounts.map((fac) {
    //   return fac.firstStep();
    // });
    // Iterable<PassiveAccountFactory> passiveFac =
    //     initialData.passiveAccounts.map((fac) => fac.firstStep());
    // Iterable<CategoryFactory> categoriesFac =
    //     initialData.categories.map((fac) => fac.firstStep());
    // Iterable<TransactionsFactory> transFac =
    //     initialData.transactions.map((fac) => fac.firstStep());
    // Iterable<RecurringTransactionsFactory> recTransFac =
    //     initialData.recurringTransactions.map((fac) => fac.firstStep());

    // activeFac = activeFac.map((fac) => fac.secondStep());
    // passiveFac = passiveFac.map((fac) => fac.secondStep());
    // categoriesFac = categoriesFac.map((fac) => fac.secondStep());
    // transFac = transFac.map((fac) => fac.secondStep());
    // recTransFac = recTransFac.map((fac) => fac.secondStep());
    for (var f in initialData.activeAccounts) {
      f.build();
    }
    for (var f in initialData.passiveAccounts) {
      f.build();
    }
    for (var f in initialData.categories) {
      f.build();
    }
    for (var f in initialData.transactions) {
      f.build();
    }
    for (var f in initialData.recurringTransactions) {
      f.build();
    }
  }

  int get nextAccountNumber => _data.getNewAccountNumber();
  int get nextTransactionNumber => _data.getNewTransactionNumber();

  Datastorage get data => _data; // TODO: remove getter for _data

  String get nextUuid => _uuid.v1();
  Bookable? getAccount(int accountNr) {
    // ignore: unnecessary_cast
    Iterable<Bookable?> remote =
        [_data.allRemoteAccounts, _data.categories].expand((x) => x);

    return remote.firstWhere(
        (element) => element != null && element.accountNumber == accountNr,
        orElse: () => null);
  }

  Bookable getAccountById(String id) {
    return _data.allRemoteAccounts.firstWhere((element) => element.id == id,
        orElse: () =>
            _data.categories.firstWhere((element) => element.id == id));
  }

  Transaction? getTransactionById(String id) {
    // ignore: unnecessary_cast
    return (_data.transactions as Iterable<Transaction?>)
        .firstWhere((element) => element?.id == id);
  }

  void addActiveAccounts(Iterable<ActiveAccount> acc) {
    _data.activeAccounts.addAll(acc);
  }

  void addPassiveAccounts(Iterable<PassiveAccount> acc) {
    _data.passiveAccounts.addAll(acc);
  }

  void addCategories(List<Category> categories) {
    _data.categories.addAll(categories);
  }

  Iterable<Category> getAllCategories() => _copyList(_data.categories);

  Iterable<ActiveAccount> getAllActiveAccounts() =>
      _copyList(_data.activeAccounts);

  Iterable<PassiveAccount> getAllPassiveAccounts() =>
      _copyList(_data.passiveAccounts);

  Iterable<Transaction> getAllTransactions() => _copyList(_data.transactions);

  Iterable<RecurringTransactions> getAllRecurringTransactions() =>
      _copyList(_data.recurringTransactions);

  Future<F> readStorage<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path, String id) async {
    return await _dataAdapter.load<F, T, S, U>(
        path, id, _getFac<F, T, S, U>(path));
  }

  Future writeStorage(DatabaseObject obj) async {
    _dataAdapter.store(obj);
  }

  F _getFac<F extends Factory<T, S, F, U>, T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>, U extends Updater<T>>(EntityPaths path) {
    switch (path) {
      case EntityPaths.activeaccount:
        return ActiveAccountFactory(this) as F;

      case EntityPaths.passiveaccount:
        return PassiveAccountFactory(this) as F;
      case EntityPaths.category:
        return CategoryFactory(this) as F;
      case EntityPaths.transaction:
        return TransactionsFactory(this) as F;
      case EntityPaths.recurringtransations:
        return RecurringTransactionsFactory(this) as F;
    }
  }

  Iterable<T> _copyList<T>(Iterable<T> i) {
    List<T> n = <T>[];
    n.addAll(i);
    return n;
  }

  Future<void> appendTransaction(Transaction transaction) {
    _data.transactions.add(transaction);
    transaction.soll.appendTransaction(transaction);
    transaction.haben.appendTransaction(transaction);
    return _dataAdapter.store(transaction);
  }
}
