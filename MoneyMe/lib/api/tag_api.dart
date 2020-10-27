import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/utils/store.dart';

import 'package:http/http.dart' as http;

class TagApi {
  static var urlGetTagsList = 'https://fin.mal.vn/api/tag/list';
  static var urlAddTag = 'https://fin.mal.vn/api/tag/add';

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

  static Future<dynamic> addTag(Tag newTag) async {
    var token = await Store.getToken();
    var mapTag = Map<String, dynamic>();
    mapTag["icon"] = newTag.icon;
    mapTag["jar_id"] = newTag.jarID;
    mapTag["parent_id"] = newTag.parentID;
    mapTag["tag_name"] = newTag.tagName;
    mapTag["type"] = int.tryParse(newTag.type);
    print(json.encode(mapTag));
    // var response = await http.post(
    //   urlGetTagsList,
    //   headers: {
    //     "Authorization": token,
    //   },
    //   body: json.encode(mapTag),
    // );

    // if (response.statusCode != 200) {
    //   return response.statusCode.toString();
    // }

    // return Response.map(json.decode(response.body));
  }
}
