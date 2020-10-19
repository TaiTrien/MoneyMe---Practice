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

  static Future<dynamic> income(Transaction transaction, List mapJar) async {
    var transactionData;

    var mapTransaction = Map<String, dynamic>();
    mapTransaction["date"] = transaction.date;
    mapTransaction["desc"] = transaction.desc;
    mapTransaction["price"] = transaction.price;
    mapTransaction["tag_id"] = transaction.tagID;
    mapTransaction["jar_ids"] = mapJar;

    var token = await Store.getToken();
    var response = await http.post(
      urlIncome,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: json.encode(mapTransaction),
    );
    transactionData = Response.map(json.decode(response.body));
    return transactionData;
  }

  static Future<dynamic> spend(Transaction transaction) async {
    var transactionData;

    var mapTransaction = Map<String, dynamic>();
    mapTransaction["date"] = transaction.date;
    mapTransaction["desc"] = transaction.desc;
    mapTransaction["price"] = transaction.price;
    mapTransaction["tag_id"] = transaction.tagID;

    var token = await Store.getToken();
    var response = await http.post(
      urlSpend,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: json.encode(mapTransaction),
    );
    transactionData = Response.map(json.decode(response.body));
    return transactionData;
  }
}
