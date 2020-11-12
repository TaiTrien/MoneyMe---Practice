import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/inform_account/account_screen.dart';
import 'package:MoneyMe/screens/categories/categories_screen.dart';
import 'package:MoneyMe/screens/home/home_screen.dart';
import 'package:MoneyMe/screens/transaction/add/add_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     CategoriesScreen(typeScreen: TypeScreen.management),
//     AddTransactionScreen(),
//     AccountScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DoubleBackToCloseApp(
//         snackBar: const SnackBar(
//           backgroundColor: kPrimaryColor,
//           content: Text(
//             'Bấm quay lại lần nữa để thoát',
//             textAlign: TextAlign.center,
//           ),
//         ),
//         child: Center(
//           child: _widgetOptions.elementAt(_selectedIndex),
//         ),
//       ),
//       bottomNavigationBar: FancyBottomNavigation(
//         circleColor: kPrimaryColor,
//         inactiveIconColor: kSecondaryColor,
//         textColor: kPrimaryColor,
//         tabs: [
//           TabData(iconData: Icons.home, title: "Trang chủ"),
//           TabData(iconData: Icons.category, title: "Hạng mục"),
//           TabData(iconData: Icons.add, title: "Thêm giao dịch"),
//           TabData(iconData: Icons.account_circle, title: "Trang cá nhân"),
//         ],
//         onTabChangedListener: (position) {
//           setState(() {
//             _selectedIndex = position;
//           });
//         },
//       ),
//     );
//   }
// }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddTransactionScreen(),
    CategoriesScreen(typeScreen: TypeScreen.management),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
