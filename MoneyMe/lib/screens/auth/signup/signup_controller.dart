import 'package:MoneyMe/api/user_api.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/components/custom_dialog.dart';
import 'package:MoneyMe/components/custom_action_btn.dart';
import 'package:MoneyMe/utils/connection.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpController {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var retypedPasswordController = TextEditingController();

  Notify notify = Notify();

  dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    retypedPasswordController.dispose();
  }

  handleSignUp(BuildContext context) async {
    String fullName = nameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();
    String retypedPassword = retypedPasswordController.text.trim();

    bool isNameValid = Validator.isName(fullName);
    bool isPhoneNumberValid = Validator.isPhoneNumber(phoneNumber);
    bool isPasswordValid = Validator.isPassword(password);
    bool isRetypedPasswordValid = (Validator.isPassword(retypedPassword) && retypedPassword == password);

    if (!isNameValid || !isPhoneNumberValid || !isPasswordValid || !isRetypedPasswordValid) return null;

    bool isConnected = await Connection.isInternetConnected();
    if (!isConnected) return notify.error(message: "Thiết bị của bạn chưa kết nối Internet");

    var registerData = await UserApi.getRegisterResponse(name: fullName, userName: phoneNumber, password: password);
    if (registerData.code != 200) {
      return notify.error(message: registerData.apiMessagse);
    }

    //handle when register successfully
    var token = await UserApi.getGlobalToken(phoneNumber: phoneNumber, password: password);

    await Store.setToken(token);
    dialogRegisterSuccessfully(context, registerData);
  }

  Future dialogRegisterSuccessfully(BuildContext context, Response registerData) {
    return showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(context, '/loadingScreen', (_) => false);
        });
        return CustomDiaglog(
          title: registerData.apiMessagse,
          subTitle: "Chào mừng bạn đến với Money Me",
          titleWidget: Image.asset(
            'assets/images/welcome.gif',
            fit: BoxFit.contain,
          ),
          actions: [
            CustomActionButton(
              titleBtn: 'Hủy',
              color: Colors.grey,
              colorTitle: Colors.white,
              onPress: () {
                Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (_) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
