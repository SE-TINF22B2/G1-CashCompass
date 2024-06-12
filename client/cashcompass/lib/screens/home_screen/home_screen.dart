import 'package:cashcompass/screens/add_category/add_category_screen.dart';
import 'package:cashcompass/screens/friends/friends_screen.dart';
import 'package:cashcompass/screens/latest_transactions/latest_transactions_screen.dart';
import 'package:cashcompass/screens/profile/profile_screen.dart';
import 'package:cashcompass/screens/wallets/wallets_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({super.key, this.initialIndex = 2});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  static const List<Widget> _screens = [
    ProfileScreen(),
    WalletsScreen(),
    LatestTransactionsScreen(),
    AddCategoryScreen(),
    FriendsScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go('/$index');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.creditcard),
            activeIcon: Icon(CupertinoIcons.creditcard,
                color: CupertinoColors.activeBlue),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.arrow_up_arrow_down_square),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_grid_2x2),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2),
          )
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return _screens[index];
          },
        );
      },
    );
  }
}
