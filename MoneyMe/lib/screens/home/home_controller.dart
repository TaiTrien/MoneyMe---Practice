import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/user/user_bloc.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/screens/transaction/edit/edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeController {
  final BuildContext context;

  // ignore: close_sinks
  UserBloc _userBloc;
  // ignore: close_sinks
  JarBloc _jarBloc;
  // ignore: close_sinks

  dynamic userInfo;
  dynamic expenseHistory;
  HomeController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);
  }
  toEditTransactionScreen(Transaction selectedTransaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTransactionScreen(
          selectedTransaction: selectedTransaction,
        ),
      ),
    );
  }

  get totalExpense => _jarBloc.state.remainMoney;
  get userName => _userBloc.state.user.name;
  get jarsList => _jarBloc.state.jarsList;
}
