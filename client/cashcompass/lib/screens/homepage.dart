import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      title: "MemeTilder",
      debugShowCheckedModeBanner: false,
      theme: getGlobalTheme(ThemeData.light()),
      darkTheme: getGlobalTheme(ThemeData.dark()),
      themeMode: currentUserProvider.themeMode,
      navigatorKey: Controller.instance.navigatorKey,
      routes: {
        '/loading': (context) => const LoadingScreen(),
        '/navBar': (context) => const NavScaffold(),
      },
      initialRoute: '/loading',
    );
  }
}
