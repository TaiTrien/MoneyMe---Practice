import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TestController {
  final tokenStorage = new FlutterSecureStorage();

  Future<void> deleteToken() async {
    await tokenStorage.delete(key: "token");
  }
}
