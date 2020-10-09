import 'dart:convert';

import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/utils/store.dart';

import 'package:http/http.dart' as http;

class JarApi {
  static var urlGetJarsList = 'https://fin.mal.vn/api/jars/list';
  static var urlEditJarPercentage = 'https://fin.mal.vn/api/jars/edit';

  static Future<dynamic> getJarsList() async {
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

  static Future<dynamic> editJarPercentage(List<Jar> jarsList, JarBloc _jarBloc) async {
    var listMapJars = <Map>[];
    for (int i = 0; i < 6; i++) {
      Jar jar = jarsList[i];
      listMapJars.add(
        {
          "jar_id": jar.jarID,
          "percentage": int.parse(jar.percentage).toInt(),
        },
      );
    }

    var token = await Store.getToken();
    try {
      var response = await http.put(
        "https://fin.mal.vn/api/jars/edit",
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: json.encode(listMapJars),
      );
      print(json.encode(listMapJars));
      var data = Response.map(json.decode(response.body));
      if (data.code != 200) return data.apiMessagse;

      _jarBloc.add(UpdateJarsData(jarsList));
      return data.apiMessagse;
    } catch (e) {
      print(e);
    }
  }
}
