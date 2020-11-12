import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/screens/account/inform_account/account_screen.dart';
import 'package:MoneyMe/screens/categories/categories_screen.dart';
import 'package:MoneyMe/screens/home/home_screen.dart';
import 'package:MoneyMe/screens/statistic/statistic_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  DateTime backButtonPressTime;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    StatisticScreen(),
    CategoriesScreen(typeScreen: TypeScreen.management),
    AccountScreen(),
  ];

  Future<bool> onWillPop(BuildContext context) async {
    DateTime currentTime = DateTime.now();

    bool isFirstTime = backButtonPressTime == null || currentTime.difference(backButtonPressTime) > Duration(seconds: 2);

    if (isFirstTime) {
      Notify().error(message: "Nhấn thêm 1 lần để thoát");
      backButtonPressTime = currentTime;
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                  gap: 8,
                  activeColor: Colors.white,
                  color: Colors.grey,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 800),
                  tabBackgroundColor: Colors.grey[800],
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Trang chủ',
                      backgroundColor: kPrimaryColor,
                    ),
                    GButton(
                      icon: Icons.bar_chart,
                      text: 'Thống kê',
                      backgroundColor: kPrimaryColor,
                    ),
                    GButton(
                      icon: Icons.category,
                      text: 'Quản lý hạng mục',
                      backgroundColor: kPrimaryColor,
                    ),
                    GButton(
                      icon: Icons.account_circle,
                      text: 'Trang cá nhân',
                      backgroundColor: kPrimaryColor,
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
