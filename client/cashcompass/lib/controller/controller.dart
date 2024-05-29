import 'package:cashcompass/screens/my_app/my_app.dart';
import 'package:cashcompass_hook/cashcompass_hook.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:flutter/cupertino.dart';

class Controller {
  static late final Controller instance;
  static late final Accountmanager accountManager;
  Controller() {
    instance = this;
  }
  start() async {
    accountManager = Accountmanager(dataAdapter: MockDataAdapter());
    await accountManager.init();
    runApp(const MyApp());
  }
}
