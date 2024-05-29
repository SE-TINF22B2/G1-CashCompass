import 'package:cashcompass/screens/my_app/my_app.dart';
import 'package:cashcompass/utils/navigation_provider.dart';
import 'package:flutter/cupertino.dart';

class Controller {
  static late final Controller instance;

  final NavigationProvider _navProvider = NavigationProvider();

  Controller() {
    instance = this;
  }

  NavigationProvider get navProvider => _navProvider;

  start() {
    runApp(const MyApp());
  }
}
