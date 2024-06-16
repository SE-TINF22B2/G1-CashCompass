// ignore_for_file: avoid_function_literals_in_foreach_calls

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
  final Datastorage _data = Datastorage();
  final Uuid _uuid = const Uuid();
  late final DataAdapter _dataAdapter;
  Accountmanager({required DataAdapter dataAdapter}) {
    _dataAdapter = dataAdapter;
  }

  /// Initializes the Accountmamager via the [Accountmanager._dataAdapter].
  ///
  /// First, this function retrives the initialdatapull from the dataadapter and after that the two-step-factories are called.
  /// The two-step-factories are necessary for connecting all acconts to their transactions.
  /// After those are connected, the actuall build method is called, which makes the data in this accountManager consistent.
  Future<void> init() async {
    var data = await _dataAdapter.getInitialPull(this);
    Iterable<ActiveAccountFactory> activeFac = data.activeAccounts.map((fac) {
      return fac.firstStep();
    });
    Iterable<PassiveAccountFactory> passiveFac =
        data.passiveAccounts.map((fac) => fac.firstStep());
    Iterable<CategoryFactory> categoriesFac =
        data.categories.map((fac) => fac.firstStep());
    Iterable<TransactionsFactory> transFac =
        data.transactions.map((fac) => fac.firstStep());
    Iterable<RecurringTransactionsFactory> recTransFac =
        data.recurringTransactions.map((fac) => fac.firstStep());

    activeFac = activeFac.map((fac) => fac.secondStep());
    passiveFac = passiveFac.map((fac) => fac.secondStep());
    categoriesFac = categoriesFac.map((fac) => fac.secondStep());
    transFac = transFac.map((fac) => fac.secondStep());
    recTransFac = recTransFac.map((fac) => fac.secondStep());
    activeFac.forEach((f) => _data.activeAccounts.add(f.build()));
    passiveFac.forEach((f) => _data.passiveAccounts.add(f.build()));
    categoriesFac.forEach((f) => _data.categories.add(f.build()));
    transFac.forEach((f) => _data.transactions.add(f.build()));
    recTransFac.forEach((f) => _data.recurringTransactions.add(f.build()));
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

  /// Reads the [_dataAdapter] for an object of type [T] and path [path] with [id] as the id and returns the objects [Factory].
  Future<F> readStorage<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path, String id) async {
    return await _dataAdapter.load<F, T, S, U>(
        path, id, _getFactory<F, T, S, U>(path));
  }

  Future writeStorage(DatabaseObject obj) async {
    _dataAdapter.store(obj);
  }

  F _getFactory<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path) {
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
}
