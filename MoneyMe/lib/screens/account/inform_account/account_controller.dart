import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';

class AccountController {
  BuildContext context;
  JarBloc _jarBloc;

  List<Jar> jars;
  double necPercentage;
  double ltssPercentage;
  double ffaPercentage;
  double eduPercentage;
  double playPercentage;
  double givePercentage;
  int percent;
  bool canSlide = true;

  AccountController({this.context}) {
    _jarBloc = BlocProvider.of<JarBloc>(context);
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
    double sum = 100;
    sum = sum - (necPercentage + ltssPercentage + ffaPercentage + eduPercentage + playPercentage + givePercentage);
    return int.parse(sum.toStringAsFixed(0));
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

    _jarBloc.add(UpdateRemainPercentage(percent));
  }

  resetPercentage() {
    necPercentage = double.parse(jars[0].percentage);
    ltssPercentage = double.parse(jars[1].percentage);
    ffaPercentage = double.parse(jars[2].percentage);
    eduPercentage = double.parse(jars[3].percentage);
    playPercentage = double.parse(jars[4].percentage);
    givePercentage = double.parse(jars[5].percentage);
  }

  void signOut(BuildContext context) {
    Store.deleteToken();
    Navigator.pushNamedAndRemoveUntil(context, '/signInScreen', (route) => false);
  }

  void toChangePasswordScreen() {
    Navigator.pushNamed(context, '/changePasswordScreen');
  }

  handleUpdatePercentage() async {
    if (percent < 0) {
      Notify().error(
        message: "Tổng số hũ phải là 100%, bạn đã vượt quá ${percent.abs()} %",
      );
      return;
    }

    if (percent > 0 && percent < 100) {
      Notify().error(
        message: "Tổng số hũ phải là 100%, bạn cần thêm ${percent.abs()} % để cập nhật",
      );
      return;
    }

    List<Jar> newJarsList = List<Jar>();

    for (int i = 0; i < 6; i++) {
      String jarID = jars[i].jarID;
      String jarName = jars[i].jarName;
      String jarTitle = jars[i].jarTitle;
      String icon = jars[i].icon;
      String price = jars[i].price;
      double percentage = getValue(jarName: jarName.toLowerCase());
      String priceIncome = jars[i].priceIncome;
      String priceSpend = jars[i].priceSpend;

      Jar newJar = Jar(jarID, jarName, jarTitle, icon, price, percentage.round().toString(), priceIncome, priceSpend);
      newJarsList.add(newJar);
    }

    var data = await JarApi.editJarPercentage(newJarsList, _jarBloc);
    Notify().success(message: data.toString());
  }

  get jarsList => jars;
  get remainPercentage => percent;
}
