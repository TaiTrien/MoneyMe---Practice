import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticController {
  BuildContext context;
  TransactionBloc _transactionBloc;

  StatisticController({this.context}) {
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
  }
  selectDateRange() async {
    await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      locale: Locale('vi'),
      helpText: 'Chọn khoảng thời gian',
      initialEntryMode: DatePickerEntryMode.input,
    );
  }

  get transactions => _transactionBloc.state.transactionsList;
}
