import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/utils/store.dart';

import 'package:http/http.dart' as http;

class TagApi {
  static var urlGetTagsList = 'https://fin.mal.vn/api/tag/list';
  static var urlAddTag = 'https://fin.mal.vn/api/tag/add';
  static var urlEditTag = 'https://fin.mal.vn/api/tag/edit/';

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

    var response = await http.post(
      urlAddTag,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: json.encode(mapTag),
    );
    return Response.map(json.decode(response.body));
  }

  static Future<dynamic> editTag(Tag newTag) async {
    var token = await Store.getToken();
    var mapTag = Map<String, dynamic>();
    var url = urlEditTag + newTag.tagID;

    mapTag["icon"] = newTag.icon;
    mapTag["jar_id"] = newTag.jarID;
    mapTag["parent_id"] = newTag.parentID;
    mapTag["tag_name"] = newTag.tagName;
    mapTag["type"] = int.tryParse(newTag.type);
    print(json.encode(mapTag));
    print('url: ' + token);

    var response = await http.put(
      url,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: json.encode(mapTag),
    );
    return Response.map(json.decode(response.body));
  }
}
