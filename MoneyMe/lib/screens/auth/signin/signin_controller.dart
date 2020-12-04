import 'package:MoneyMe/api/user_api.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/utils/connection.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/material.dart';

class SignInController {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  bool isSignin = false;

  dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  handleSignIn(BuildContext context) async {
    if (isSignin) return;
    isSignin = true;
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();

    bool isPhoneNumberValid = Validator.isPhoneNumber(phoneNumber);
    bool isPasswordValid = Validator.isPassword(password);
    bool hasToken = await isSignedIn();
    bool isConnected = await Connection.isInternetConnected();
    if (!isConnected) return Notify().error(message: "Thiết bị của bạn chưa kết nối Internet");

    if (hasToken) {
      return Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (_) => false);
    }

    if (!isPhoneNumberValid || !isPasswordValid) return null;

    var token = await UserApi.getGlobalToken(
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
    );

    if (token == null) {
      Notify notify = Notify();
      return notify.error(message: 'Tài khoản hoặc mật khẩu không chính xác');
    }

    await Store.setToken(token);
    // Handle if validate successfuly
    isSignin = false;
    Navigator.pushNamedAndRemoveUntil(context, '/loadingScreen', (_) => false);
  }

  Future<bool> isSignedIn() async {
    var token = await Store.getToken();
    return (token != null) ? true : false;
  }
}
