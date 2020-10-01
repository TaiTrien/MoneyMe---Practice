import 'package:MoneyMe/api/user_api.dart';
import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/screens/auth/components/custom_dialog.dart';
import 'package:MoneyMe/screens/auth/signin/components/custom_action_btn.dart';
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
    if (!isConnected) return dialogConnectFailed(context);

    var registerData = await UserApi.getRegisterResponse();
    if (registerData.code != 200) return dialogRegisterFailed(context, registerData);

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
          Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (_) => false);
        });
        return CustomDiaglog(
          title: registerData.apiMessagse,
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

  Future dialogRegisterFailed(BuildContext context, Response registerData) {
    return showDialog(
      context: context,
      builder: (context) => CustomDiaglog(
        title: registerData.apiMessagse,
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
