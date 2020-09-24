import 'dart:convert';
import 'dart:ffi';

import 'package:MoneyMe/blocs/user/user_bloc.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class HomeController {
  dynamic userInfo;
  dynamic jarsList;
  dynamic expenseHistory;
  HomeController({this.userInfo, this.jarsList, this.expenseHistory});

  int sumExpense() {
    int totalExpense = 0;
    for (int i = 0; i < 6; i++) {
      try {
        totalExpense += int.parse(jarsList["data"][i]["price"]);
      } catch (e) {
        print(e);
      }
    }
    return totalExpense;
  }

  get totalExpense => sumExpense();
  get userName => userInfo["data"]["name"];
}
