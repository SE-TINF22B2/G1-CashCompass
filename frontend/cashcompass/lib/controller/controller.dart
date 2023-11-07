import 'package:cashcompass/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';

class Controller {
  static late final Controller instance;
  Controller() {
    instance = this;
  }
  start() {
    runApp(const MyApp());
  }
}
