import 'dart:convert';

import 'package:MoneyMe/models/reponse.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:http/http.dart' as http;

class TransactionApi {
  static var urlGetTransactionsList = 'https://fin.mal.vn/api/input/history';
  static var urlSpend = 'https://fin.mal.vn/api/input/spend';
  static var urlIncome = 'https://fin.mal.vn/api/input/income';
  static var urlEdit = "https://fin.mal.vn/api/input/";

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

  static Future<dynamic> delete(int typeTransaction, String inputID) async {
    var token = await Store.getToken();

    var url = urlEdit + 'income/$inputID';

    if (typeTransaction == 2) {
      url = urlEdit + 'spend/$inputID';
    }
    var response = await http.delete(
      url,
      headers: {
        "Authorization": token,
      },
    );

    return Response.map(json.decode(response.body));
  }

  static Future<dynamic> editTransaction(String inputID, Transaction transaction) async {
    var token = await Store.getToken();
    var url = urlEdit + 'income/$inputID';

    if (transaction.type == '2') {
      url = urlEdit + 'spend/$inputID';
    }
    var mapTransaction = Map<String, dynamic>();
    mapTransaction["date"] = transaction.date;
    mapTransaction["desc"] = transaction.desc;
    mapTransaction["price"] = transaction.price;
    mapTransaction["tag_id"] = transaction.tagID;

    var response = await http.put(
      url,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: json.encode(mapTransaction),
    );

    return Response.map(json.decode(response.body));
  }
}
