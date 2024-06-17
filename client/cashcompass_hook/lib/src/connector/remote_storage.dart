import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/sync_controller.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteStorage implements DataAdapter {
  // ignore: unused_field
  final RestClient _client;
  RemoteStorage(this._client);
  @override
  Future<InitialPullData> getInitialPull(Accountmanager accountManager) async {
    http.Response response = await _client.get("/data/Accounts");
    if (response.statusCode != 200) {
      throw Error();
    }

    var responseBody = json.decode(response.body);

    List<Map<String, dynamic>> data = responseBody["value"]
        .map<Map<String, dynamic>>((entry) => entry as Map<String, dynamic>)
        .toList();

    print(data);

    var pullData = InitialPullData(
        recurringTransactions: [],
        activeAccounts: data
            .map((object) => ActiveAccountFactory(accountManager)
                .deserialise(data: object, id: object["ID"]))
            .toList(),
        // activeAccounts: data
        //     .map(
        //       (key, value) {
        //         return MapEntry(
        //             key,
        //             ActiveAccountFactory(accountManager)
        //                 .deserialise(data: value, id: key));
        //       },
        //     )
        //     .values
        //     .toList(),
        passiveAccounts: [],
        transactions: [],
        categories: [],
        lastsync: DateTime.now());

    print(pullData.activeAccounts);

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
