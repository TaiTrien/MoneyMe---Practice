import 'package:MoneyMe/screens/auth/loading/loading_screen.dart';
import 'package:MoneyMe/screens/auth/signin/signin_screen.dart';
import 'package:MoneyMe/screens/auth/signup/signup_screen.dart';
import 'package:MoneyMe/screens/mainscreen/test.dart';

final routes = {
  '/loadingScreen': (context) => LoadingScreen(),
  '/signUpScreen': (context) => SignUpScreen(),
  '/testScreen': (context) => Test(),
  '/signInScreen': (context) => SignInScreen(),
};
