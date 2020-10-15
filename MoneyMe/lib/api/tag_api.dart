import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/utils/store.dart';

import 'package:http/http.dart' as http;

class TagApi {
  static var urlGetTagsList = 'https://fin.mal.vn/api/tag/list';

  static Future<dynamic> getTagsList() async {
    var tagsListData;
    var token = await Store.getToken();
    var response = await http.get(
      urlGetTagsList,
      headers: {
        "Authorization": token,
      },
    );

    if (response.statusCode != 200) {
      return response.statusCode.toString();
    }
    tagsListData = Response.map(json.decode(response.body));

    return tagsListData;
  }
}
