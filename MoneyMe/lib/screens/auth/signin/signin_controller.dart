import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/models/user.dart';
import 'package:MoneyMe/screens/auth/components/custom_dialog.dart';
import 'package:MoneyMe/utils/connection.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'components/custom_action_btn.dart';

class SignInController {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var urlLogin = 'https://fin.mal.vn/api/user/login';
  var urlValidateUser = 'https://fin.mal.vn/api/user/info';

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
      return Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (_) => false);
    }

    if (!isConnected) {
      return showDialog(
        context: context,
        builder: (context) => CustomDiaglog(
          title: "Thiết bị của bạn chưa kết nối Internet",
          subTitle: "Vui lòng kiểm tra lại kết nối của bạn",
          image: Image.asset(
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

    dynamic response = await getApiResponse(
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
    );

    if (!(response is User)) {
      return dialogWrongInfo(context, response);
    }

    await Store.setToken(response.getToken);
    // Handle if validate successfuly
    Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (_) => false);
  }

  Future dialogWrongInfo(BuildContext context, Response response) {
    return showDialog(
      context: context,
      builder: (context) => CustomDiaglog(
        title: response.apiMessagse,
        subTitle: "Vui lòng kiểm tra lại tên tài khoản/mật khẩu",
        image: Image.asset('assets/images/404.gif'),
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
              Navigator.pushNamedAndRemoveUntil(context, '/signUpScreen', (_) => false);
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> getApiResponse({String phoneNumber, String password}) async {
    var response = await http.post(
      urlLogin,
      body: {
        "user_name": phoneNumber,
        "password": password,
      },
    );
    if (response.statusCode != 200) return Response.map(json.decode(response.body));

    return User.map(json.decode(response.body));
  }

  Future<bool> isSignedIn() async {
    var token = await Store.getToken();
    return (token != null) ? true : false;
  }

  // Future<bool> validateUser({String token}) async {
  //   var response = await http.get(
  //     urlValidateUser,
  //     headers: {"Authorization": token},
  //   );
  //   if (response.statusCode != 200) return true;
  //   return false;
  // }
}
