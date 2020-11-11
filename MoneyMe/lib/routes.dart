import 'package:MoneyMe/screens/account/change_password/change_password_screen.dart';
import 'package:MoneyMe/screens/auth/signin/signin_screen.dart';
import 'package:MoneyMe/screens/auth/signup/signup_screen.dart';
import 'package:MoneyMe/screens/categories/add/add_tag_screen.dart';
import 'package:MoneyMe/screens/categories/add/icon_screen.dart';
import 'package:MoneyMe/screens/categories/categories_screen.dart';
import 'package:MoneyMe/screens/categories/edit/edit_tag_screen.dart';
import 'package:MoneyMe/screens/home/home_screen.dart';
import 'package:MoneyMe/screens/loading/loading_screen.dart';
import 'package:MoneyMe/screens/main_screen.dart';
import 'package:MoneyMe/screens/transaction/add/add_screen.dart';

final routes = {
  '/loadingScreen': (context) => LoadingScreen(),
  '/signUpScreen': (context) => SignUpScreen(),
  '/homeScreen': (context) => HomeScreen(),
  '/signInScreen': (context) => SignInScreen(),
  '/mainScreen': (context) => MainScreen(),
  '/changePasswordScreen': (context) => ChangePasswordScreen(),
  '/addTransactionScreen': (context) => AddTransactionScreen(),
  '/categoriesScreen': (context) => CategoriesScreen(typeScreen: TypeScreen.select),
  '/addTagScreen': (context) => AddTagScreen(),
  '/editTagScreen': (context) => EditTagScreen(),
  '/iconScreen': (context) => IconScreen(),
};
