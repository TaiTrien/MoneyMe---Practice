import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/blocs/user/user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeController {
  final BuildContext context;

  // ignore: close_sinks
  UserBloc _userBloc;
  // ignore: close_sinks
  JarBloc _jarBloc;
  // ignore: close_sinks
  TransactionBloc _transactionBloc;
  dynamic userInfo;
  dynamic expenseHistory;
  HomeController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
  }

  int sumExpense() {
    int totalExpense = 0;
    for (int i = 0; i < 6; i++) {
      try {
        totalExpense += int.parse(_jarBloc.state.jarsList[i].price);
      } catch (e) {
        print(e);
      }
    }
    return totalExpense;
  }

  get totalExpense => sumExpense();
  get userName => _userBloc.state.user.name;
  get transactionsList => _transactionBloc.state.transactionsList;
  get jarsList => _jarBloc.state.jarsList;
}
