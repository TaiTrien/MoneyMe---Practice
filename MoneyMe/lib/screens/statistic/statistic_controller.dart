import 'package:MoneyMe/api/statistic_api.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StatisticController {
  BuildContext context;
  TransactionBloc _transactionBloc;

  StatisticController({this.context}) {
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
  }
  handleStatistic() async {
    var dateRange = await selectDateRange();
    var formatter = new DateFormat('yyyy-MM-dd');
    var startDate = formatter.format(dateRange.start).toString();
    var endDate = formatter.format(dateRange.end).toString();

    var transactions = await StatisticApi.getStatistic(startDate, endDate);
    if (transactions == null) return Notify().error(message: 'Thống kê thất bại');
  }

  selectDateRange() async {
    return await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      locale: Locale('vi'),
      helpText: 'Chọn khoảng thời gian',
    );
  }

  get transactions => _transactionBloc.state.transactionsList;
}
