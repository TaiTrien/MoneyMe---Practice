import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/screens/transaction/edit/edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryController {
  BuildContext context;
  TransactionBloc _transactionBloc;
  TagBloc _tagBloc;

  HistoryController({this.context}) {
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    _tagBloc = BlocProvider.of<TagBloc>(context);
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
    _tagBloc.add(ResetSelectedTag(null));
    _transactionBloc.add(ResetCurrentTransaction(null));
  }

  toExit() {
    Navigator.pop(context);
  }

  get transactionList => _transactionBloc.state.transactionsList;
}
