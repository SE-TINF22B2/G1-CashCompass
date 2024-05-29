import 'package:cashcompass/controller/controller.dart';
import 'package:cashcompass/screens/categories/categories_screen.dart';
import 'package:cashcompass/screens/friends/friends_screen.dart';
import 'package:cashcompass/screens/latest_transactions/latest_transactions_screen.dart';
import 'package:cashcompass/screens/profile/profile_screen.dart';
import 'package:cashcompass/screens/wallets/wallets_screen.dart';
import 'package:cashcompass/utils/navigation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NavigationScaffold extends StatefulWidget {
  const NavigationScaffold({super.key});

  @override
  State<NavigationScaffold> createState() => _NavigationScaffoldState();
}

class _NavigationScaffoldState extends State<NavigationScaffold> {
  static const _pages = [
    ProfileScreen(),
    WalletsScreen(),
    LatestTransactionsScreen(),
    CategoriesScreen(),
    FriendsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    return Stack(
      children: [
        CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            currentIndex: navProvider.selectedIndex,
            onTap: (index) =>
                Controller.instance.navProvider.updateIndex(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.creditcard),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.time),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_grid_2x2),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_3),
              )
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return _pages[navProvider.selectedIndex];
              },
            );
          },
        )
      ],
    );
  }
}
