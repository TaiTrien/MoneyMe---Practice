import 'package:MoneyMe/api/transaction_api.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/models/transaction.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddController {
  BuildContext context;
  TagBloc _tagBloc;
  AddController({this.context}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
  }
  final dateController = TextEditingController();
  final noteController = TextEditingController();
  final moneyController = TextEditingController();

  void toCategoriesScreen() {
    Navigator.pushNamed(context, '/categoriesScreen');
  }

  handleAddTransaction() async {
    String date = dateController.text.trim();
    String desc = noteController.text.trim();
    String price = moneyController.text.trim();
    String tagID = _tagBloc.state.selectedTag.tagID;

    Transaction transaction = new Transaction(date: date, desc: desc, price: price, tagID: tagID);
    var data = await TransactionApi.spend(transaction);
  }
}
