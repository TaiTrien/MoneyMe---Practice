import 'dart:convert';

import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/utils/store.dart';

import 'package:http/http.dart' as http;

class StatisticApi {
  static var urlGetStatistic = 'https://fin.mal.vn/api/input/input_report/jars_report?';
  static var urlEditJarPercentage = 'https://fin.mal.vn/api/jars/edit';

  static Future<dynamic> getStatistic(String startDate, String endDate) async {
    var transactions;
    var token = await Store.getToken();
    var url = urlGetStatistic + 'begin=$startDate&end=$endDate';

    var response = await http.get(
      url,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) return null;
    transactions = Response.map(json.decode(response.body));
    return transactions.data;
  }

  static Future<dynamic> editJarPercentage(List<Jar> jarsList, JarBloc _jarBloc) async {
    var listMapJars = <Map>[];
    for (int i = 0; i < 6; i++) {
      Jar jar = jarsList[i];
      listMapJars.add(
        {
          "jar_id": jar.jarID,
          "percentage": jar.percentage,
        },
      );
    }

    var token = await Store.getToken();
    try {
      var response = await http.put(
        urlEditJarPercentage,
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: json.encode(listMapJars),
      );
      //print(json.encode(listMapJars));
      var data = Response.map(json.decode(response.body));
      if (data.code != 200) return data.apiMessagse;

      _jarBloc.add(UpdateJarsData(jarsList));
      return data.apiMessagse;
    } catch (e) {
      print(e);
    }
  }
}
