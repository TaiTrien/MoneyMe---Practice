import 'package:MoneyMe/models/user.dart';
import 'package:MoneyMe/screens/auth/components/custom_dialog.dart';
import 'package:MoneyMe/utils/connection.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'components/custom_action_btn.dart';

class SignInController {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var urlLogin = 'https://fin.mal.vn/api/user/login';
  var urlValidateUser = 'https://fin.mal.vn/api/user/info';

  handleLogin(BuildContext context) async {
    bool hasToken = await isSignedIn();
    bool isConnected = await Connection.isInternetConnected();

    if (hasToken) {
      return Navigator.pushNamed(context, '/testScreen');
    }

    if (!isConnected) {
      return showDialog(
        context: context,
        builder: (context) => CustomDiaglog(
          content: "Thiết bị của bạn chưa kết nối Internet",
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

    User user = await getUser();

    if (user == null) {
      return notFoundUser(context);
    }

    Store.setToken(user.getToken);
    String token = user.getToken;
    bool isValidToken = await validateUser(token: token);

    if (!isValidToken) {
      return notFoundUser(context);
    }

    // Handle if validate successfuly

    Navigator.pushNamed(context, '/testScreen');
  }

  Future<Function> notFoundUser(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => CustomDiaglog(
        content: "Người dùng này chưa được đăng ký",
        titleWidget: Image.asset('assets/images/404.gif'),
        actions: [
          CustomActionButton(
            titleBtn: 'Hủy',
            color: Colors.grey,
            colorTitle: Colors.white,
            onPress: () {
              Navigator.of(context).pop();
            },
          ),
          CustomActionButton(
            titleBtn: 'Đăng ký ngay',
            color: Colors.green[400],
            colorTitle: Colors.white,
            onPress: () {
              Navigator.pushNamed(context, '/signUpScreen');
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> getUser() async {
    var response = await http.post(
      urlLogin,
      body: {
        "user_name": phoneNumberController.text,
        "password": passwordController.text,
      },
    );
    if (response.statusCode == 200)
      return User.map(json.decode(response.body));
    else
      return null;
  }

  Future<bool> isSignedIn() async {
    var token = await Store.getToken();
    return (token != null) ? true : false;
  }

  Future<bool> validateUser({String token}) async {
    var response = await http.get(
      urlValidateUser,
      headers: {"Authorization": token},
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
