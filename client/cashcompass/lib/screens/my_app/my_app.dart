import 'package:cashcompass/screens/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
        title: 'Flutter Demo',
        theme: CupertinoThemeData(),
        home: CupertinoPageScaffold(
          child: SafeArea(
            child: ProfileScreen(),
          ),
        ));
  }
}
