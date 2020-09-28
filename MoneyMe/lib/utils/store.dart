import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var tokenStorage = new FlutterSecureStorage();

class Store {
  static setToken(token) async {
    await tokenStorage.write(key: "token", value: token);
  }

  static getToken() async {
    return await tokenStorage.read(key: "token");
  }

  static deleteToken() async {
    await tokenStorage.delete(key: "token");
  }
}
