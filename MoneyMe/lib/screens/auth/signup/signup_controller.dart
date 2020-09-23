import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/models/user.dart';
import 'package:MoneyMe/screens/auth/components/custom_dialog.dart';
import 'package:MoneyMe/screens/auth/signin/components/custom_action_btn.dart';
import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:MoneyMe/utils/connection.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpController {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var retypedPasswordController = TextEditingController();
  var urlRegister = "https://fin.mal.vn/api/user/register";

  dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    retypedPasswordController.dispose();
  }

  Future<dynamic> getApiResponse() async {
    var response = await http.post(
      urlRegister,
      body: {
        "name": nameController.text,
        "user_name": phoneNumberController.text,
        "password": passwordController.text,
      },
    );
    return Response.map(json.decode(response.body));
  }

  handleSignUp(BuildContext context) async {
    String fullName = nameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();
    String retypedPassword = retypedPasswordController.text.trim();
    SignInController signInController = SignInController();

    bool isNameValid = Validator.isName(fullName);
    bool isPhoneNumberValid = Validator.isPhoneNumber(phoneNumber);
    bool isPasswordValid = Validator.isPassword(password);
    bool isRetypedPasswordValid = (Validator.isPassword(retypedPassword) && retypedPassword == password);

    if (!isNameValid || !isPhoneNumberValid || !isPasswordValid || !isRetypedPasswordValid) return null;

    bool isConnected = await Connection.isInternetConnected();
    if (!isConnected) return dialogConnectFailed(context);

    Response response = await getApiResponse();
    if (response.code != 200) return dialogRegisterFailed(context, response);

    //handle when register successfully
    User newUser = await signInController.getApiResponse(phoneNumber: phoneNumber, password: password);

    await Store.setToken(newUser.getToken);
    dialogRegisterSuccessfully(context, response);
  }

  Future dialogRegisterSuccessfully(BuildContext context, Response response) {
    return showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (_) => false);
        });
        return CustomDiaglog(
          title: response.apiMessagse,
          subTitle: "Chào mừng bạn đến với Money Me",
          image: Image.asset(
            'assets/images/welcome.gif',
            fit: BoxFit.contain,
          ),
          actions: [
            CustomActionButton(
              titleBtn: 'Hủy',
              color: Colors.grey,
              colorTitle: Colors.white,
              onPress: () {
                Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (_) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Future dialogRegisterFailed(BuildContext context, Response response) {
    return showDialog(
      context: context,
      builder: (context) => CustomDiaglog(
        title: response.apiMessagse,
        subTitle: "Vui lòng đăng ký tài khoản khác",
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
            titleBtn: 'Đăng ký tài khoản khác',
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

  Future dialogConnectFailed(BuildContext context) {
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
}
