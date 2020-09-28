import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:http/http.dart' as http;

class JarApi {
  static var urlGetJarsList = 'https://fin.mal.vn/api/jars/list';

  static Future<dynamic> getJarsListInfo() async {
    var jarsListData;
    var token = await Store.getToken();
    var response = await http.get(
      urlGetJarsList,
      headers: {
        "Authorization": token,
      },
    );

    if (response.statusCode != 200) {
      return response.statusCode.toString();
    }
    jarsListData = Response.map(json.decode(response.body));

    return jarsListData;
  }
}
