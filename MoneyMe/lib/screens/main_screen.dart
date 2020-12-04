import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/screens/account/inform_account/account_screen.dart';
import 'package:MoneyMe/screens/categories/categories_screen.dart';
import 'package:MoneyMe/screens/home/home_screen.dart';
import 'package:MoneyMe/screens/statistic/statistic_screen.dart';
import 'package:flutter/material.dart';

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
    CategoriesScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> onWillPop(BuildContext context) async {
    DateTime currentTime = DateTime.now();

    bool isFirstTime = backButtonPressTime == null || currentTime.difference(backButtonPressTime) > Duration(seconds: 2);

    if (isFirstTime) {
      Notify().show(message: "Nhấn thêm 1 lần để thoát", color: Colors.blue);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Thống kê',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Quản lý danh mục',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Trang cá nhân',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kPrimaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
