import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/api/transaction_api.dart';
import 'package:MoneyMe/api/user_api.dart';
import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/transaction/bloc/transactionbloc_bloc.dart';
import 'package:MoneyMe/blocs/user/user_bloc.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/models/user.dart';
import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingController {
  BuildContext context;
  UserBloc _userBloc;
  JarBloc _jarBloc;
  TransactionBloc _transactionBloc;
  var signInController = new SignInController();

  LoadingController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    handleLoadData();
  }

  handleLoadData() async {
    bool isSignedIn = await signInController.isSignedIn();
    if (!isSignedIn) return Navigator.pushNamedAndRemoveUntil(context, '/signInScreen', (_) => false);

    await loadUserData();
    await loadJarsData();
    await loadTransactionsData();
    try {
      return Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (_) => false);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadUserData() async {
    var userData;
    try {
      userData = await UserApi.getUserInfo();
      User user = User.map(userData.data);
      _userBloc.add(LoadUserInfo(user));
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadJarsData() async {
    var jarsListData;
    List<Jar> jarsList = List<Jar>();
    jarsListData = await JarApi.getJarsListInfo();

    for (int i = 0; i < jarsListData.data.length; i++) {
      Jar jar = Jar.map(jarsListData.data[i]);
      jarsList.add(jar);
    }
    _jarBloc.add(UpdateJarsData(jarsList));
  }

  Future<void> loadTransactionsData() async {
    var transactionsListData;
    List<Transaction> transactionsList = List<Transaction>();

    transactionsListData = await TransactionApi.getTransactionsList();
    int transactionsListLength = int.parse(transactionsListData.data["total"]);

    for (int i = 0; i < transactionsListLength; i++) {
      Transaction transaction = Transaction.map(transactionsListData.data, i);
      transactionsList.add(transaction);
    }
    _transactionBloc.add(LoadTransactionsData(transactionsList));
  }
}
