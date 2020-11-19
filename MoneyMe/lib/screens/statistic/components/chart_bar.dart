import 'dart:math';

import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarValue {
  final String time;
  final int value;

  BarValue({this.time, this.value, Color color});
}

// ignore: must_be_immutable
class ChartsDemo extends StatefulWidget {
  ChartsDemo() : super();
  List<Transaction> expenses;
  List<Transaction> revenues;
  TransactionBloc _transactionBloc;

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  @override
  void initState() {
    super.initState();
    widget._transactionBloc = BlocProvider.of<TransactionBloc>(context);
    widget.expenses = widget._transactionBloc.state.expenses;
    widget.revenues = widget._transactionBloc.state.revenues;
    seriesList = _createRandomData();
  }

  //
  List<charts.Series> seriesList;

  List<charts.Series<BarValue, String>> _createRandomData() {
    final expenses = widget.expenses
        .map(
          (expense) => BarValue(
            time: expense.date,
            value: int.tryParse(expense.price),
          ),
        )
        .toList();
    final revenues = widget.revenues
        .map(
          (revenue) => BarValue(
            time: revenue.date,
            value: int.tryParse(revenue.price),
          ),
        )
        .toList();
    return [
      charts.Series<BarValue, String>(
        id: 'Revenue',
        domainFn: (BarValue transaction, _) => transaction.time.toString(),
        measureFn: (BarValue transaction, _) => transaction.value,
        data: revenues,
        fillColorFn: (BarValue transaction, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      ),
      charts.Series<BarValue, String>(
        id: 'Expenses',
        domainFn: (BarValue transaction, _) => transaction.time.toString(),
        measureFn: (BarValue transaction, _) => transaction.value,
        data: expenses,
        fillColorFn: (BarValue transaction, _) {
          return charts.MaterialPalette.red.shadeDefault;
        },
      ),
    ];
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
      ),
      // domainAxis: new charts.DateTimeAxisSpec(
      //   tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
      //   tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
      //     day: new charts.TimeFormatterSpec(format: 'EEE', transitionFormat: 'EEE', noonFormat: 'EEE'),
      //   ),
      //   showAxisLine: false,
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: state.transactionsList.isEmpty
                ? Center(
                    child: Text('Bạn chưa có giao dịch nào gần đây'),
                  )
                : barChart(),
          );
        },
      ),
    );
  }
}
