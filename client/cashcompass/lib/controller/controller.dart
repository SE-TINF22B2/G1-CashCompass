import 'package:cashcompass/screens/my_app/my_app.dart';
import 'package:flutter/cupertino.dart';

class Controller {
  static late final Controller instance;

  Controller() {
    instance = this;
  }

  start() {
    runApp(const MyApp());
  }
}
