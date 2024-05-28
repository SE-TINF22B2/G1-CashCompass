import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/category/category_factory.dart';
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_factory.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/connector/sync_controller.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_factory.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';

class MockDataAdapter extends DataAdapter {
  Map<String, Map<String, dynamic>> db = {
    EntityPaths.activeaccount.path: {
      "1": {
        "id": 1,
        "isUploaded": true,
        "name": "active1",
        "account_number": 1,
        "soll": [],
        "haben": []
      }
    },
    EntityPaths.category.path: {
      "2": {
        "id": 2,
        "isUploaded": true,
        "name": "cate1",
        "account_number": 2,
        "soll": [],
        "haben": []
      }
    },
    EntityPaths.passiveaccount.path: {
      "3": {
        "id": 3,
        "isUploaded": true,
        "name": "pass1",
        "account_number": 3,
        "soll": [],
        "haben": []
      }
    },
    EntityPaths.recurringtransations.path: {
      "4": {
        "id": 4,
        "isUploaded": true,
        "soll": 1,
        "haben": 2,
        "amount": 500,
        "start": DateTime.now().toIso8601String(),
        "end": DateTime.now().toIso8601String(),
        "interval": "XXXXX"
      }
    },
    EntityPaths.transaction.path: {
      "5": {
        "id": 5,
        "isUploaded": true,
        "soll": 1,
        "haben": 2,
        "amount": 500,
        "timestamp": DateTime.now().toIso8601String(),
        "transactionNumber": 1,
        "label": "TestTransaction1"
      }
    }
  };

  @override
  Future<InitialPullData> getInitialPull(Accountmanager accountManager) {
    var x = InitialPullData(
        recurringTransactions: db[EntityPaths.recurringtransations.path]!
            .map(
              (key, value) {
                return MapEntry(
                    key,
                    RecurringTransactionsFactory(accountManager)
                        .deserialise(data: value, id: key));
              },
            )
            .values
            .toList(),
        activeAccounts: db[EntityPaths.activeaccount.path]!
            .map(
              (key, value) {
                return MapEntry(
                    key,
                    ActiveAccountFactory(accountManager)
                        .deserialise(data: value, id: key));
              },
            )
            .values
            .toList(),
        passiveAccounts: db[EntityPaths.passiveaccount.path]!
            .map(
              (key, value) {
                return MapEntry(
                    key,
                    PassiveAccountFactory(accountManager)
                        .deserialise(data: value, id: key));
              },
            )
            .values
            .toList(),
        transactions: db[EntityPaths.transaction.path]!
            .map(
              (key, value) {
                return MapEntry(
                    key,
                    TransactionsFactory(accountManager)
                        .deserialise(data: value, id: key));
              },
            )
            .values
            .toList(),
        categories: db[EntityPaths.category.path]!
            .map(
              (key, value) {
                return MapEntry(
                    key,
                    CategoryFactory(accountManager)
                        .deserialise(data: value, id: key));
              },
            )
            .values
            .toList(),
        lastsync: DateTime.now());

    return Future.value(x);
  }

  @override
  Future<F> load<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path, String id, F factory) {
    var d = db[path.path];
    // two sep factory should somehow be called!!!!
    // TODO
    if (d == null || d[id] == null) {
      throw Exception();
    }
    return Future.value(factory.deserialise(data: d[id], id: id, isRemote: true));
  }

  @override
  Future store(DatabaseObject obj) async {
    Future.value(db[obj.getPath()] = obj.getSerialiser().toJson());
  }
}
