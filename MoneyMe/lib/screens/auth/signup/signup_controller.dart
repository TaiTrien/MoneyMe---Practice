import 'dart:convert';

import 'package:MoneyMe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SignUpController {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();
  var urlRegister = "https://fin.mal.vn/api/user/register";
  String helpText;
  Future<dynamic> registerUser() async {
    var response = await http.post(
      urlRegister,
      body: {
        "name": nameController.text,
        "user_name": phoneNumberController.text,
        "password": passwordController.text,
      },
    );
    if (response.statusCode == 200)
      return User.map(json.decode(response.body));
    else {
      return null;
    }
  }

  handleSignUp() async {
    User newUser = await registerUser();
    if (newUser != null)
      print('userToken:' + newUser.getToken);
    else
      print('no');
  }
}
