import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/inform_account/account_screen.dart';
import 'package:MoneyMe/screens/categories/categories_screen.dart';
import 'package:MoneyMe/screens/home/home_screen.dart';
import 'package:MoneyMe/screens/transaction/add/add_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoriesScreen(typeScreen: TypeScreen.management),
    AddTransactionScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text(
            'Bấm quay lại lần nữa để thoát',
            textAlign: TextAlign.center,
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: kPrimaryColor,
        inactiveIconColor: kSecondaryColor,
        textColor: kPrimaryColor,
        tabs: [
          TabData(iconData: Icons.home, title: "Trang chủ"),
          TabData(iconData: Icons.category, title: "Hạng mục"),
          TabData(iconData: Icons.add, title: "Thêm giao dịch"),
          TabData(iconData: Icons.account_circle, title: "Trang cá nhân"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            _selectedIndex = position;
          });
        },
      ),
    );
  }
}
