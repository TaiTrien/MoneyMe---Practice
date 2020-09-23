import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeController {
  final tokenStorage = new FlutterSecureStorage();

  Future<void> deleteToken() async {
    await tokenStorage.delete(key: "token");
  }
}
