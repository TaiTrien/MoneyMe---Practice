import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountController {
  BuildContext context;
  JarBloc _jarBloc;

  double necPercentage;
  double ltssPercentage;
  double ffaPercentage;
  double eduPercentage;
  double playPercentage;
  double givePercentage;
  int remainPercentage;

  AccountController({this.context}) {
    _jarBloc = BlocProvider.of<JarBloc>(context);

    necPercentage = double.parse(_jarBloc.state.jarsList[0].percentage);
    ltssPercentage = double.parse(_jarBloc.state.jarsList[1].percentage);
    ffaPercentage = double.parse(_jarBloc.state.jarsList[2].percentage);
    eduPercentage = double.parse(_jarBloc.state.jarsList[3].percentage);
    playPercentage = double.parse(_jarBloc.state.jarsList[4].percentage);
    givePercentage = double.parse(_jarBloc.state.jarsList[5].percentage);
    remainPercentage = getRemainPercentage();
  }

  double getValue({String jarName}) {
    switch (jarName) {
      case "nec":
        {
          return necPercentage;
        }
        break;
      case "ltss":
        {
          return ltssPercentage;
        }
        break;

      case "ffa":
        {
          return ffaPercentage;
        }
        break;

      case "edu":
        {
          return eduPercentage;
        }
        break;

      case "play":
        {
          return playPercentage;
        }
        break;

      case "give":
        {
          return givePercentage;
        }
        break;
    }
    return 0;
  }

  onChange({double value, String jarName}) {
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
    remainPercentage = getRemainPercentage();
  }

  void signOut(BuildContext context) {
    Store.deleteToken();
    Navigator.pushNamedAndRemoveUntil(context, '/signInScreen', (route) => false);
  }

  void toChangePasswordScreen() {
    Navigator.pushNamed(context, '/changePasswordScreen');
  }

  int getRemainPercentage() {
    double sum = 100;
    sum -= (necPercentage + ltssPercentage + ffaPercentage + eduPercentage + playPercentage + givePercentage);
    return sum.round();
  }

  // int getRemainPercentage() {
  //   int remainRatio = 100;
  //   List<Jar> jarsList = _jarBloc.state.jarsList;
  //   try {
  //     for (int i = 0; i < jarsList.length; i++) {
  //       remainRatio -= int.parse(jarsList[i].percentage);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return remainRatio;
  // }

  get jarsList => _jarBloc.state.jarsList;
}
