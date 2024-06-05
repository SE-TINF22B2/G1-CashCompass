import 'package:cashcompass/screens/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:cashcompass/screens/auth/auth_screen.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

//TODO: Replace with real Authentication logic
bool isLoggedIn = true;

final GoRouter _router = GoRouter(
  initialLocation: '/2', // Startet mit TransactionScreen
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/',
      redirect: (context, state) => isLoggedIn ? null : '/auth',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: ':index',
          builder: (context, state) {
            final index = int.parse(state.pathParameters['index']!);
            return HomeScreen(initialIndex: index);
          },
        ),
      ],
    ),
  ],
);
