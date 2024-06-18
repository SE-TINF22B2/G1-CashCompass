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
      "11": {
        "ID": 11,
        "isUploaded": true,
        "name": "ING",
        "account_number": 11,
        "soll": [],
        "haben": []
      },
      "12": {
        "ID": 12,
        "isUploaded": true,
        "name": "Sparkasse",
        "account_number": 12,
        "soll": [],
        "haben": []
      },
      "13": {
        "ID": 13,
        "isUploaded": true,
        "name": "BAR",
        "account_number": 13,
        "soll": [],
        "haben": []
      },
      "45": {
        "ID": 45,
        "isUploaded": true,
        "name": "active1",
        "account_number": 45,
        "soll": [],
        "haben": []
      },
    },
    EntityPaths.category.path: {
      "21": {
        "ID": 21,
        "isUploaded": true,
        "name": "GiftsDonations",
        "account_number": 21,
        "icon": "GiftsDonations",
        "soll": [],
        "haben": []
      },
      "22": {
        "ID": 22,
        "isUploaded": true,
        "name": "Groceries",
        "account_number": 22,
        "icon": "Groceries",
        "soll": [],
        "haben": []
      },
      "23": {
        "ID": 23,
        "isUploaded": true,
        "name": "Transport",
        "account_number": 23,
        "icon": "Transport",
        "soll": [],
        "haben": []
      },
      "24": {
        "ID": 24,
        "isUploaded": true,
        "name": "Loans",
        "account_number": 24,
        "icon": "Loans",
        "soll": [],
        "haben": []
      },
    },
    EntityPaths.passiveaccount.path: {
      "31": {
        "ID": 31,
        "isUploaded": true,
        "name": "pass1",
        "account_number": 31,
        "soll": [],
        "haben": []
      }
    },
    EntityPaths.recurringtransations.path: {
      "41": {
        "id": 41,
        "isUploaded": true,
        "soll": 11,
        "haben": 21,
        "amount": 500,
        "start": DateTime.now().toIso8601String(),
        "end": DateTime.now().toIso8601String(),
        "interval": "XXXXX"
      }
    },
    EntityPaths.transaction.path: {
      "51": {
        "id": 51,
        "isUploaded": true,
        "soll": 21,
        "haben": 11,
        "amount": 100,
        "timestamp": DateTime.now().toIso8601String(),
        "transactionNumber": 1,
        "label": "Geschenk von Max"
      },
      "52": {
        "id": 52,
        "isUploaded": true,
        "soll": 12,
        "haben": 22,
        "amount": 6.50,
        "timestamp": DateTime.now().toIso8601String(),
        "transactionNumber": 2,
        "label": "Döner"
      },
      "53": {
        "id": 53,
        "isUploaded": true,
        "soll": 11,
        "haben": 23,
        "amount": 25,
        "timestamp": DateTime.now().toIso8601String(),
        "transactionNumber": 3,
        "label": "Fahrkosten für Rudi"
      },
      "54": {
        "id": 54,
        "isUploaded": true,
        "soll": 24,
        "haben": 13,
        "amount": 50,
        "timestamp": DateTime.now().toIso8601String(),
        "transactionNumber": 4,
        "label": "Putzen bei Omi"
      },
      "55": {
        "id": 55,
        "isUploaded": true,
        "soll": 24,
        "haben": 11,
        "amount": 450,
        "timestamp": DateTime.now().toIso8601String(),
        "transactionNumber": 5,
        "label": "Gehalt"
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
    return Future.value(
        factory.deserialise(data: d[id], id: id, isRemote: true));
  }

  @override
  Future store(DatabaseObject obj) async {
    Future.value(db[obj.getPath()] = obj.getSerialiser().toJson());
  }
}
