import 'package:MoneyMe/screens/account/change_password/change_password_screen.dart';
import 'package:MoneyMe/screens/auth/signin/signin_screen.dart';
import 'package:MoneyMe/screens/auth/signup/signup_screen.dart';
import 'package:MoneyMe/screens/home/home_screen.dart';
import 'package:MoneyMe/screens/loading/loading_screen.dart';
import 'package:MoneyMe/screens/main_screen.dart';

final routes = {
  '/loadingScreen': (context) => LoadingScreen(),
  '/signUpScreen': (context) => SignUpScreen(),
  '/homeScreen': (context) => HomeScreen(),
  '/signInScreen': (context) => SignInScreen(),
  '/mainScreen': (context) => MainScreen(),
  '/changePasswordScreen': (context) => ChangePasswordScreen(),
};
