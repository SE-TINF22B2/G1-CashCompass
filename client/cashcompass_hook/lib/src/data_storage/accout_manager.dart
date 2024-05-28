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

    _data.activeAccounts.addAll(activeFac.map((f) => f.build()));
    _data.passiveAccounts.addAll(passiveFac.map((f) => f.build()));
    _data.categories.addAll(categoriesFac.map((f) => f.build()));
    _data.transactions.addAll(transFac.map((f) => f.build()));
    _data.recurringTransactions.addAll(recTransFac.map((f) => f.build()));
  }

  int get nextAccountNumber => _data.getNewAccountNumber();
  int get nextTransactionNumber => _data.getNewTransactionNumber();
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

  List<Category> getAllCategories() {
    List<Category> ret = [];
    ret.addAll(_data.categories);
    return ret;
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
}
