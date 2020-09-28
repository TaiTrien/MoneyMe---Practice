import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:http/http.dart' as http;

class TransactionApi {
  static var urlGetTransactionsList = 'https://fin.mal.vn/api/input/history';

  static Future<dynamic> getTransactionsList() async {
    var transactionListData;
    var token = await Store.getToken();
    var response = await http.get(
      urlGetTransactionsList,
      headers: {
        "Authorization": token,
      },
    );

    if (response.statusCode != 200) {
      return response.statusCode.toString();
    }
    transactionListData = Response.map(json.decode(response.body));
    return transactionListData;
  }
}
