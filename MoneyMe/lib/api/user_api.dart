import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  static String urlLogin = 'https://fin.mal.vn/api/user/login';
  static String urlRegister = "https://fin.mal.vn/api/user/register";
  static String urlGetUserInfo = 'https://fin.mal.vn/api/user/info';

  static Future<String> getGlobalToken({String phoneNumber, String password}) async {
    String token;
    var response = await http.post(
      urlLogin,
      body: {
        "user_name": phoneNumber,
        "password": password,
      },
    );
    if (response.statusCode != 200) return null;

    token = Response.map(json.decode(response.body)).data;
    return token;
  }

  static Future<bool> registerStatus({String name, String userName, String password}) async {
    bool isRegistered;
    var response = await http.post(
      urlRegister,
      body: {
        "name": name,
        "user_name": userName,
        "password": password,
      },
    );
    var statusCode = Response.map(json.decode(response.body)).code;

    isRegistered = (statusCode == 200) ? true : false;
    return isRegistered;
  }

  static Future<dynamic> getUserInfo() async {
    var userData;
    var token = await Store.getToken();
    var response = await http.get(
      urlGetUserInfo,
      headers: {
        "Authorization": token,
      },
    );

    if (response.statusCode != 200) {
      return response.statusCode.toString();
    }

    userData = Response.map(json.decode(response.body));
    return userData;
  }
}
