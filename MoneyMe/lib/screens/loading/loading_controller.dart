import 'dart:convert';

import 'package:MoneyMe/api/user_api.dart';
import 'package:MoneyMe/blocs/user/user_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:MoneyMe/screens/auth/signin/signin_screen.dart';
import 'package:MoneyMe/screens/dashboard/home/home_screen.dart';
import 'package:MoneyMe/utils/connection.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoadingController {
  BuildContext context;
  LoadingController({this.context}) {
    loadUserData();
  }
  var signInController = new SignInController();

  var urlGetJarsList = 'https://fin.mal.vn/api/jars/list';
  var urlGetExpenseHistory = 'https://fin.mal.vn/api/input/history';

  void loadUserData() async {
    bool isSignedIn = await signInController.isSignedIn();
    bool isInternetConnected = await Connection.isInternetConnected();

    if (!isInternetConnected) {
      return Notify().show(
        message: "Vui lòng kiểm tra kết nối",
        color: Colors.teal[400],
        timeout: 10,
      );
    }

    var token = await Store.getToken();

    dynamic userInfo = await UserApi.getUserInfo();

    dynamic jarsList = await getData(token: token, url: urlGetJarsList);
    dynamic expenseHistory = await getData(token: token, url: urlGetExpenseHistory);

    if (userInfo == null || jarsList == null) return;

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => isSignedIn
              ? HomeScreen(
                  userInfo: userInfo,
                  jarsList: jarsList,
                  expenseHistory: expenseHistory,
                )
              : SignInScreen(),
        ),
        (_) => false);
  }

  Future<dynamic> getData({String token, String url}) async {
    var data;
    var response = await http.get(
      url,
      headers: {
        "Authorization": token,
      },
    );

    if (response.statusCode != 200) {
      return response.statusCode.toString();
    }

    data = json.decode(response.body);
    return data;
  }
}
