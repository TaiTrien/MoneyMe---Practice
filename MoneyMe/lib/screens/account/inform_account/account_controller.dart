import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';

class AccountController {
  BuildContext context;
  JarBloc _jarBloc;
  TransactionBloc _transactionBloc;

  List<Jar> jars;
  double necPercentage;
  double ltssPercentage;
  double ffaPercentage;
  double eduPercentage;
  double playPercentage;
  double givePercentage;
  int percent;
  bool canSlide = true;
  Notify notify = Notify();

  AccountController({this.context}) {
    _jarBloc = BlocProvider.of<JarBloc>(context);
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    jars = _jarBloc.state.jarsList;

    necPercentage = double.parse(jars[0].percentage);
    ltssPercentage = double.parse(jars[1].percentage);
    ffaPercentage = double.parse(jars[2].percentage);
    eduPercentage = double.parse(jars[3].percentage);
    playPercentage = double.parse(jars[4].percentage);
    givePercentage = double.parse(jars[5].percentage);
    percent = getRemainPercentage();
  }

  int getRemainPercentage() {
    int sum = 100;
    sum = sum - (necPercentage.toInt() + ltssPercentage.toInt() + ffaPercentage.toInt() + eduPercentage.toInt() + playPercentage.toInt() + givePercentage.toInt());
    return sum;
  }

  handleUpdatePercentage() async {
    if (percent.toInt() < 0) {
      notify.error(
        message: "Tổng số hũ phải là 100%, bạn đã vượt quá ${percent.toInt().abs()} %",
      );
      return;
    }

    if (percent.toInt() > 0 && percent.toInt() < 100) {
      notify.error(
        message: "Tổng số hũ phải là 100%, bạn cần thêm ${percent.toInt().abs()} % để cập nhật",
      );
      return;
    }

    List<Jar> newJarsList = List<Jar>();

    for (int i = 0; i < 6; i++) {
      String jarID = jars[i].jarID;
      String jarName = jars[i].jarName;
      String jarTitle = jars[i].jarTitle;
      String icon = jars[i].icon;
      int price = jars[i].price;
      int percentage = getValue(jarName: jarName.toLowerCase()).toInt();
      String priceIncome = jars[i].priceIncome;
      String priceSpend = jars[i].priceSpend;

      Jar newJar = Jar(jarID, jarName, jarTitle, icon, price, percentage.toString(), priceIncome, priceSpend);
      newJarsList.add(newJar);
    }

    var data = await JarApi.editJarPercentage(newJarsList, _jarBloc);
    notify.success(message: data.toString());
  }

  double getValue({String jarName}) {
    if (jarName == "nec")
      return necPercentage;
    else if (jarName == "ltss")
      return ltssPercentage;
    else if (jarName == "ffa")
      return ffaPercentage;
    else if (jarName == "edu")
      return eduPercentage;
    else if (jarName == "play")
      return playPercentage;
    else if (jarName == "give") return givePercentage;
    return 0;
  }

  onSliderChange({double value, String jarName}) {
    if (jarName == "nec")
      necPercentage = value;
    else if (jarName == "ltss")
      ltssPercentage = value;
    else if (jarName == "ffa")
      ffaPercentage = value;
    else if (jarName == "edu")
      eduPercentage = value;
    else if (jarName == "play")
      playPercentage = value;
    else if (jarName == "give") givePercentage = value;
    percent = getRemainPercentage();
    //print(percent);
    print('getRemainPercentage: ' + percent.toString());

    _jarBloc.add(UpdateRemainPercentage(percent));
  }

  onSliderStop({double value, String jarName}) {
    if (jarName == "nec")
      necPercentage = value;
    else if (jarName == "ltss")
      ltssPercentage = value;
    else if (jarName == "ffa")
      ffaPercentage = value;
    else if (jarName == "edu")
      eduPercentage = value;
    else if (jarName == "play")
      playPercentage = value;
    else if (jarName == "give") givePercentage = value;
    percent = getRemainPercentage();
    while (percent < 0) {
      value--;
      if (jarName == "nec")
        necPercentage = value;
      else if (jarName == "ltss")
        ltssPercentage = value;
      else if (jarName == "ffa")
        ffaPercentage = value;
      else if (jarName == "edu")
        eduPercentage = value;
      else if (jarName == "play")
        playPercentage = value;
      else if (jarName == "give") givePercentage = value;
      percent = getRemainPercentage();
    }
    print(percent);

    _jarBloc.add(UpdateRemainPercentage(percent));
  }

  void signOut(BuildContext context) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      title: 'Bạn có muốn đăng xuất không?',
      onConfirmBtnTap: () {
        Store.deleteToken();
        _transactionBloc.add(ResetCurrentTransaction(null));
        Navigator.pushNamedAndRemoveUntil(context, '/signInScreen', (route) => false);
      },
      confirmBtnColor: Colors.red,
    );
  }

  void toChangePasswordScreen() {
    Navigator.pushNamed(context, '/changePasswordScreen');
  }

  get jarsList => jars;
}
