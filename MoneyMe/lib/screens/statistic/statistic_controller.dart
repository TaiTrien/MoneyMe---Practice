import 'package:MoneyMe/api/statistic_api.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticController {
  BuildContext context;
  List<Transaction> transactionList = List<Transaction>();

  StatisticController({this.context}) {
    // loadThisMonthReport();
  }

  Future<List<Transaction>> loadThisMonthReport() async {
    var formatter = new DateFormat('yyyy-MM-dd');
    DateTime firstDay = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime lastday = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

    var startDate = formatter.format(firstDay).toString();
    var endDate = formatter.format(lastday).toString();

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

  Future<List<Transaction>> handleStatistic() async {
    //var dateRange = await selectDateRange();
    // if (dateRange == null) return [];

    var formatter = new DateFormat('yyyy-MM-dd');
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime lastDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

    var startDate = formatter.format(firstDayOfMonth).toString();
    var endDate = formatter.format(lastDayOfMonth).toString();

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
    return await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      locale: Locale('vi'),
      helpText: 'Chọn khoảng thời gian',
    );
  }

  get transactions => transactionList;
}
