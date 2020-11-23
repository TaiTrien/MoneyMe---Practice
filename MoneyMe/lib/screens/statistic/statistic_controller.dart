import 'package:MoneyMe/api/statistic_api.dart';
import 'package:MoneyMe/blocs/statistic/statistic_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StatisticController {
  BuildContext context;
  List<Transaction> transactionList = List<Transaction>();
  StatisticBloc _statisticBloc;
  var formatter = new DateFormat('dd-MM-yyyy');

  StatisticController({this.context}) {
    _statisticBloc = BlocProvider.of<StatisticBloc>(context);
  }

  Future<List<Transaction>> handleStatistic() async {
    var startDate = formatter.format(_statisticBloc.state.startDate).toString();
    var endDate = formatter.format(_statisticBloc.state.endDate).toString();

    var transactions = await StatisticApi.getStatistic(startDate, endDate);
    if (transactions == null) return Notify().error(message: 'Thống kê thất bại');

    int transactionsListLength = transactions.length;
    for (int i = 0; i < transactionsListLength; i++) {
      Transaction transaction = Transaction.map(transactions[i]);
      transaction.date = Formatter.formatDate(transaction.date);
      transactionList.add(transaction);
    }
    return transactionList;
  }

  selectDateRange() async {
    var dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      locale: Locale('vi'),
      helpText: 'Chọn khoảng thời gian',
    );
    if (dateRange == null) return;
    _statisticBloc.add(LoadStatistic(dateRange.start, dateRange.end));
  }

  get transactions => transactionList;
}
