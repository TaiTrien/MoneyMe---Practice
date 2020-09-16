import 'package:MoneyMe/screens/auth/signin/signin_screen.dart';
import 'package:MoneyMe/screens/auth/signup/signup_screen.dart';
import 'package:MoneyMe/screens/mainscreen/test.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  '/': (BuildContext context) => SignInScreen(),
  SignUpScreen.screenID: (BuildContext context) => SignUpScreen(),
  Test.screenID: (BuildContext context) => Test(),
};
