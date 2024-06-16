// ignore_for_file: unused_field

import 'dart:developer';

import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/connector/locale_storage.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/connector/remote_storage.dart';
import 'package:cashcompass_hook/src/connector/secured_rest_client.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

/// This class is basically responsible for distributing the data to the local storage as well as the remote storage.
///
/// Distributing writes to the data is done by simply creating the [Future]s for both storages and enqueuing them into [_lastingFutures].
/// This way, we achieve a seamless write for the UI.
///
/// And reading values if done by calling read on both, the local and remote storage, and we prioritize values returned from the local storage.
///
/// Objects of this call are supposed to be closed by calling close() for writing all futures to the storages

class SyncController implements DataAdapter {
  late LocaleStorage _localStorage;
  late RemoteStorage _remoteStorage;
  SecuredRestClient httpClient;
  final List<Future> _lastingFutures = [];
  SyncController({required this.httpClient}) {
    _localStorage = LocaleStorage();
    _remoteStorage = RemoteStorage(httpClient);
  }

  /// Returns the latest [InitialPullData] from the remote or local storage.
  ///
  /// Fetches both [InitialPullData] and compares their [InitialPullData.lastsync].
  /// The newer one is chosen as the source of truth and gets returned.
  @override
  Future<InitialPullData> getInitialPull(Accountmanager accountmanager) async {
    var remote = _remoteStorage
        .getInitialPull(accountmanager)
        .timeout(const Duration(seconds: 5));
    var local = _localStorage.getInitialPull(accountmanager);
    InitialPullData? localData, remoteData;
    try {
      localData = await local;
    } catch (l, s) {
      log("Error while loading local data: ", error: l, stackTrace: s);
    }

    try {
      remoteData = await remote;
    } catch (e, l) {
      log("Error while loading remote data: ", error: l, stackTrace: l);
    }

    // now we've got the data -> basic decision what data to use:
    late InitialPullData data;
    if (localData != null && remoteData != null) {
      data = localData.lastsync.isAfter(remoteData.lastsync)
          ? localData
          : remoteData;
    } else if (localData == null && remoteData == null) {
      data = InitialPullData(
          recurringTransactions: [],
          activeAccounts: [],
          passiveAccounts: [],
          transactions: [],
          categories: [],
          lastsync: DateTime.now());
    } else {
      data = localData ?? remoteData!;
    }
    return data;
  }

  /// Loads specific [T] from storage. [_localStorage] gets prefered. Throws an Exception if this object does not exist.
  @override
  Future<F> load<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path, String id, F factory) async {
    F? ret;
    var storages = [_localStorage, _remoteStorage];
    var i = 0;
    while (ret == null && i < storages.length) {
      try {
        ret = await _localStorage.load<F, T, S, U>(path, id, factory);
      } on Exception catch (e) {
        log('Error while loading obj $path::$id from ${storages[i]}', error: e);
      }
      i++;
    }

    if (ret == null) {
      throw Exception("Did not find object");
    } else {
      return ret;
    }
  }

  /// Stores the overgiven object in the given object in both storages. It is identified by the obj.getPath() and obj.id.
  @override
  Future store(DatabaseObject obj) {
    var local = _localStorage.store(obj);
    var remote = _remoteStorage.store(obj);
    _lastingFutures.add(remote);
    remote.then((val) {
      _lastingFutures.remove(remote);
    }, onError: (e) {
      _lastingFutures.remove(remote);
    });

    return local;
  }

  Future<void> close() async {
    for (var i in _lastingFutures) {
      await i;
    }
  }
}

abstract class DataAdapter {
  /*
    get initial data returns all the data from a medium by reading everything and loading it into a InitialPullData object which gets returned from this function.
   */
  Future<InitialPullData> getInitialPull(Accountmanager accountManager);

  /*
    Stores the overgiven object in the given medium. It is identified by the obj.getPath() and obj.id.
  */
  Future store(DatabaseObject obj);

  Future<F> load<
      F extends Factory<T, S, F, U>,
      T extends DatabaseObject<T, S, F, U>,
      S extends Serializer<T>,
      U extends Updater<T>>(EntityPaths path, String id, F factory);
}
