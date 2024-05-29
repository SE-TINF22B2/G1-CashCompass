import 'package:cashcompass/widgets/balance_overview/balance_overview.dart';
import 'package:cashcompass/widgets/balance_overview/mock_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:cashcompass/screens/auth/auth_screen.dart';

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
            child: AuthScreen(),
          ),
        ));
  }
}
