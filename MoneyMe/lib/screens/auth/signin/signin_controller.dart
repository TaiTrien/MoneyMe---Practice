import 'package:MoneyMe/api/user_api.dart';
import 'package:MoneyMe/components/custom_dialog.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/utils/connection.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_action_btn.dart';

class SignInController {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  handleSignIn(BuildContext context) async {
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();

    bool isPhoneNumberValid = Validator.isPhoneNumber(phoneNumber);
    bool isPasswordValid = Validator.isPassword(password);
    bool hasToken = await isSignedIn();
    bool isConnected = await Connection.isInternetConnected();

    if (hasToken) {
      return Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (_) => false);
    }

    if (!isConnected) {
      return showDialog(
        context: context,
        builder: (context) => CustomDiaglog(
          title: "Thiết bị của bạn chưa kết nối Internet",
          subTitle: "Vui lòng kiểm tra lại kết nối của bạn",
          titleWidget: Image.asset(
            'assets/images/noInternet.gif',
            fit: BoxFit.contain,
          ),
          actions: [
            CustomActionButton(
              titleBtn: 'Hủy',
              color: Colors.grey,
              colorTitle: Colors.white,
              onPress: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
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
    Navigator.pushNamedAndRemoveUntil(context, '/loadingScreen', (_) => false);
  }

  Future<bool> isSignedIn() async {
    var token = await Store.getToken();
    return (token != null) ? true : false;
  }
}
