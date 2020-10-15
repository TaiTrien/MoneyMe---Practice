import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:http/http.dart' as http;

class TransactionApi {
  static var urlGetTransactionsList = 'https://fin.mal.vn/api/input/history';
  static var urlSpend = 'https://fin.mal.vn/api/input/spend';
  static var urlIncome = 'https://fin.mal.vn/api/input/income';

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

  static Future<dynamic> spend(Transaction transaction) async {
    var transactionListData;

    var mapTransaction = Map<String, dynamic>();
    mapTransaction["date"] = transaction.date;
    mapTransaction["desc"] = transaction.desc;
    mapTransaction["price"] = transaction.price;
    mapTransaction["tag_id"] = transaction.tagID;
    print(mapTransaction);

    var token = await Store.getToken();
    var response = await http.post(
      urlGetTransactionsList,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: json.encode(mapTransaction),
    );

    if (response.statusCode != 200) {
      return response.statusCode.toString();
    }
    transactionListData = Response.map(json.decode(response.body));
    return transactionListData;
  }
}
