import 'package:MoneyMe/api/statistic_api.dart';
import 'package:MoneyMe/blocs/statistic/statistic_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StatisticController {
  BuildContext context;
  StatisticBloc _statisticBloc;
  var formatter = new DateFormat('dd-MM-yyyy');

  StatisticController({this.context}) {
    _statisticBloc = BlocProvider.of<StatisticBloc>(context);
  }

  Future<List<Transaction>> handleStatistic() async {
    List<Transaction> transactionList = List<Transaction>();

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

  void setDateRange(DateRange dateRange) {
    DateTime today = DateTime.now();
    DateTime startDate, endDate;

    switch (dateRange) {
      case DateRange.ThisWeek:
        startDate = today.subtract(new Duration(days: today.weekday - 1));
        endDate = startDate.add(new Duration(days: 6));

        _statisticBloc.add(LoadStatistic(startDate, endDate));
        break;

      case DateRange.LastWeek:
        today = today.subtract(new Duration(days: 7));
        startDate = today.subtract(new Duration(days: today.weekday - 1));
        endDate = startDate.add(new Duration(days: 6));

        _statisticBloc.add(LoadStatistic(startDate, endDate));
        break;

      case DateRange.ThisMonth:
        startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
        endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

        _statisticBloc.add(LoadStatistic(startDate, endDate));
        break;

      case DateRange.LastMonth:
        startDate = DateTime(DateTime.now().year, DateTime.now().month - 1, 1);
        endDate = DateTime(DateTime.now().year, DateTime.now().month, 0);

        _statisticBloc.add(LoadStatistic(startDate, endDate));
        break;
      case DateRange.ThisQuarter:
        DateTime today = DateTime.now();
        int quarterNumber = ((today.month - 1) ~/ 3 + 1);
        startDate = new DateTime(today.year, (quarterNumber - 1) * 3 + 1, 1);
        endDate = DateTime(DateTime.now().year, (quarterNumber - 1) * 3 + 4, 0);

        _statisticBloc.add(LoadStatistic(startDate, endDate));
        break;
      case DateRange.LastQuarter:
        DateTime today = DateTime.now();
        int quarterNumber = ((today.month - 1) ~/ 3);
        startDate = new DateTime(today.year, (quarterNumber - 1) * 3 + 1, 1);
        endDate = DateTime(DateTime.now().year, (quarterNumber - 1) * 3 + 4, 0);

        _statisticBloc.add(LoadStatistic(startDate, endDate));
        break;
      default:
        break;
    }
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
}
