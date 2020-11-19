import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/api/tag_api.dart';
import 'package:MoneyMe/api/transaction_api.dart';
import 'package:MoneyMe/api/user_api.dart';
import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/blocs/user/user_bloc.dart';
import 'package:MoneyMe/models/icon.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/models/user.dart';
import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingController {
  BuildContext context;
  UserBloc _userBloc;
  JarBloc _jarBloc;
  TransactionBloc _transactionBloc;
  TagBloc _tagBloc;
  var signInController = new SignInController();

  LoadingController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    _tagBloc = BlocProvider.of<TagBloc>(context);
    handleLoadData();
  }

  handleLoadData() async {
    bool isSignedIn = await signInController.isSignedIn();
    if (!isSignedIn) return Navigator.pushNamedAndRemoveUntil(context, '/signInScreen', (_) => false);

    await loadUserData();
    await loadJarsData();
    await loadTransactionsData();
    await loadTagsData();

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
    jarsListData = await JarApi.getJarsList();

    for (int i = 0; i < jarsListData.data.length; i++) {
      Jar jar = Jar.map(jarsListData.data[i]);
      IconsList.icons.add(jar.icon);
      jarsList.add(jar);
    }
    _jarBloc.add(UpdateJarsData(jarsList));
  }

  Future<void> loadTagsData() async {
    var tagsListData = await TagApi.getTagsList();
    List<Tag> tagsList = List<Tag>();

    int tagsListLength = tagsListData.data.length;

    for (int i = 0; i < tagsListLength; i++) {
      Tag newTag = Tag.map(tagsListData.data[i]);

      if (!IconsList.icons.contains(newTag.icon)) IconsList.icons.add(newTag.icon);

      tagsList.add(newTag);
    }

    _tagBloc.add(LoadingTagsData(tagsList));
  }

  Future<void> loadTransactionsData() async {
    var transactionsListData;
    List<Transaction> transactionsList = List<Transaction>();

    transactionsListData = await TransactionApi.getTransactionsList();
    int transactionsListLength = int.parse(transactionsListData.data["total"]);

    for (int i = 0; i < transactionsListLength; i++) {
      Transaction transaction = Transaction.map(transactionsListData.data["items"][i]);
      transaction.date = Formatter.formatDate(transaction.date);
      transactionsList.add(transaction);
    }
    _transactionBloc.add(LoadTransactionsData(transactionsList));
  }
}
