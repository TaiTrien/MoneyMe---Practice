import 'dart:math';

import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Transaction {
  final String time;
  final int value;

  Transaction({this.time, this.value, Color color});
}

class ChartsDemo extends StatefulWidget {
  ChartsDemo() : super();

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //
  List<charts.Series> seriesList;
  TransactionBloc _transactionBloc;

  static List<charts.Series<Transaction, String>> _createRandomData() {
    final expenses = [
      Transaction(time: '2015', value: 100),
      Transaction(time: '2016', value: 200),
      Transaction(time: '2017', value: 300),
      Transaction(time: '2018', value: 400),
      Transaction(time: '2019', value: 500),
      Transaction(time: '2020', value: 800),
    ];
    final revenues = [
      Transaction(time: '2015', value: 100),
      Transaction(time: '2016', value: 200),
      Transaction(time: '2017', value: 300),
      Transaction(time: '2018', value: 400),
      Transaction(time: '2019', value: 500),
      Transaction(time: '2020', value: 800),
    ];
    return [
      charts.Series<Transaction, String>(
        id: 'Expenses',
        domainFn: (Transaction transaction, _) => transaction.time.toString(),
        measureFn: (Transaction transaction, _) => transaction.value,
        data: expenses,
        fillColorFn: (Transaction transaction, _) {
          return charts.MaterialPalette.red.shadeDefault;
        },
      ),
      charts.Series<Transaction, String>(
        id: 'Revenue',
        domainFn: (Transaction transaction, _) => transaction.time.toString(),
        measureFn: (Transaction transaction, _) => transaction.value,
        data: revenues,
        fillColorFn: (Transaction transaction, _) {
          return charts.MaterialPalette.green.shadeDefault;
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
        strokeWidthPx: 1.0,
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec: new charts.BasicNumericTickProviderSpec(desiredTickCount: 3),
      ),
      secondaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec: new charts.BasicNumericTickProviderSpec(desiredTickCount: 3),
      ),
      // domainAxis: charts.DateTimeAxisSpec(
      //   tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
      //     day: charts.TimeFormatterSpec(
      //       format: 'dd',
      //       transitionFormat: 'dd MMM',
      //     ),
      //   ),
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: barChart(),
      ),
    );
  }
}
