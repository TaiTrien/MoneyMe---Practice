import 'package:MoneyMe/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInController {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  final tokenStorage = new FlutterSecureStorage();
  var urlLogin = 'https://fin.mal.vn/api/user/login';
  var urlValidateUser = 'https://fin.mal.vn/api/user/info';

  handleLogin() async {
    User user = await getUser();
    //await tokenStorage.write(key: "token", value: user.getToken);
  }

  Future<bool> validateUser() async {
    var token = await tokenStorage.read(key: "token");
    print(token);

    var response = await http.get(
      urlValidateUser,
      headers: {"Authorization": token},
    );
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<String> getTokenFromLocal() async {
    return await tokenStorage.read(key: "token");
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
}
