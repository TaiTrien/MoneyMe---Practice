import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/utils/store.dart';

import 'package:http/http.dart' as http;

class StatisticApi {
  static var urlGetStatistic = 'https://fin.mal.vn/api/input/input_report/jars_report?';

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
}
