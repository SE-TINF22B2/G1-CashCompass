import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/category/category_factory.dart';
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_factory.dart';
import 'package:cashcompass_hook/src/connector/sync_controller.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteStorage implements DataAdapter {
  // ignore: unused_field
  final RestClient _client;
  RemoteStorage(this._client);
  @override
  Future<InitialPullData> getInitialPull(Accountmanager accountManager) async {
    http.Response response = await _client.post(
      "/data/getInitalPullData",
      "",
    );
    if (response.statusCode != 200) {
      throw Error();
    }

    final Map<String, dynamic> responseBody = json.decode(response.body);

    final Map<String, dynamic> data = responseBody["value"];

    List<Map<String, dynamic>> activeAccounts =
        data[EntityPaths.activeaccount.path]
            .map<Map<String, dynamic>>((entry) => entry as Map<String, dynamic>)
            .toList();

    List<Map<String, dynamic>> passiveAccounts =
        data[EntityPaths.passiveaccount.path]
            .map<Map<String, dynamic>>((entry) => entry as Map<String, dynamic>)
            .toList();

    List<Map<String, dynamic>> transactions = data[EntityPaths.transaction.path]
        .map<Map<String, dynamic>>((entry) => entry as Map<String, dynamic>)
        .toList();

    List<Map<String, dynamic>> categories = data[EntityPaths.category.path]
        .map<Map<String, dynamic>>((entry) => entry as Map<String, dynamic>)
        .toList();

    var pullData = InitialPullData(
        recurringTransactions: [],
        // activeAccounts: [],
        activeAccounts: activeAccounts
            .map((object) =>
                ActiveAccountFactory(accountManager).deserialise(data: object))
            .toList(),
        passiveAccounts: passiveAccounts
            .map((object) =>
                PassiveAccountFactory(accountManager).deserialise(data: object))
            .toList(),
        transactions: transactions
            .map((object) =>
                TransactionsFactory(accountManager).deserialise(data: object))
            .toList(),
        categories: categories
            .map((object) =>
                CategoryFactory(accountManager).deserialise(data: object))
            .toList(),
        lastsync: DateTime.now());

    return pullData;
  }

  @override
  Future<F> load<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path, String id, F factory) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future store(DatabaseObject obj) {
    // TODO: implement store
    throw UnimplementedError();
  }
}
