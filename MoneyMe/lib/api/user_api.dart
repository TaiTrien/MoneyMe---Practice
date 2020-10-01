import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  static String urlLogin = 'https://fin.mal.vn/api/user/login';
  static String urlRegister = "https://fin.mal.vn/api/user/register";
  static String urlGetUserInfo = 'https://fin.mal.vn/api/user/info';
  static String urlChangePassword = 'https://fin.mal.vn/api/user/password_change';

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

  static Future<dynamic> getRegisterResponse({String name, String userName, String password}) async {
    var response = await http.post(
      urlRegister,
      body: {
        "name": name,
        "user_name": userName,
        "password": password,
      },
    );
    var data = Response.map(json.decode(response.body));
    return data;
  }

  static Future<dynamic> getUserInfo() async {
    var token = await Store.getToken();
    var response = await http.get(
      urlGetUserInfo,
      headers: {
        "Authorization": token,
      },
    );
    var data = Response.map(json.decode(response.body));
    if (data.code != 200) {
      return data.apiMessagse;
    }
    return data;
  }

  static Future<dynamic> changePassword({String currentPassword, String newPassword}) async {
    var token = await Store.getToken();
    var response = await http.put(
      urlChangePassword,
      headers: {
        "Authorization": token,
      },
      body: {
        "current_password": currentPassword,
        "new_password": newPassword,
      },
    );
    var data = Response.map(json.decode(response.body));
    return data;
  }
}
