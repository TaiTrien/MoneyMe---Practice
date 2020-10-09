import 'package:MoneyMe/utils/formater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddController {
  BuildContext context;
  AddController({this.context});

  final noteController = TextEditingController();
  final moneyController = TextEditingController();

  void toCategoriesScreen() {
    Navigator.pushNamed(context, '/categoriesScreen');
  }
}
