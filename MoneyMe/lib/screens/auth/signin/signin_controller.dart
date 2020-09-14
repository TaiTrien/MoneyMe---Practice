import 'package:flutter/cupertino.dart';

class SignInController {
  var phoneNumberController = TextEditingController(text: "09");
  var passwordController = TextEditingController();
  var testt = TextEditingController(text: "123456789");

  SignInController() {}

  handleLogin() {
    print(phoneNumberController.text);
  }
}
