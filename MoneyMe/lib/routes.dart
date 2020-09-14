import 'package:MoneyMe/screens/auth/signin/signin_screen.dart';
import 'package:MoneyMe/screens/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';

final routes = {
  SignInScreen.screenID: (BuildContext context) => new SignInScreen(),
  SignUpScreen.screenID: (BuildContext context) => new SignUpScreen(),
};
