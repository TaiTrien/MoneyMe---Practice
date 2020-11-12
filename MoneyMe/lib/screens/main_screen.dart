import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/inform_account/account_screen.dart';
import 'package:MoneyMe/screens/categories/categories_screen.dart';
import 'package:MoneyMe/screens/home/home_screen.dart';
import 'package:MoneyMe/screens/statics/static_screen.dart';
import 'package:MoneyMe/screens/transaction/add/add_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     StaticScreen(),
//     CategoriesScreen(typeScreen: TypeScreen.management),
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
//           TabData(iconData: Icons.bar_chart, title: "Thống kê"),
//           TabData(iconData: Icons.category, title: "Hạng mục"),
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
  final BuildContext menuScreenContext;
  MainScreen({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      StaticScreen(),
      AddTransactionScreen(isCanBack: false),
      HomeScreen(),
      AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Trang chủ",
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.bar_chart),
        title: ("Thống kê"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: ("Thêm giao dịch"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey,
        activeContentColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.attach_money),
        title: ("Lịch sử"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle),
        title: ("Trang cá nhân"),
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popActionScreens: PopActionScreensType.once,
        bottomScreenMargin: 0.0,
        // onWillPop: () async {
        //   await showDialog(
        //     context: context,
        //     useSafeArea: true,
        //     builder: (context) => Container(
        //       height: 50.0,
        //       width: 50.0,
        //       color: Colors.white,
        //       child: RaisedButton(
        //         child: Text("Close"),
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ),
        //   );
        //   return false;
        // },
        decoration: NavBarDecoration(colorBehindNavBar: Colors.indigo, borderRadius: BorderRadius.circular(0.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.linear,
          duration: Duration(milliseconds: 100),
        ),
        navBarStyle: NavBarStyle.style16, // Choose the nav bar style with this property
      ),
    );
  }
}
