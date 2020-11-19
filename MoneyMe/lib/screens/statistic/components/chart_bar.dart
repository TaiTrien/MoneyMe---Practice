import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarValue {
  final DateTime time;
  final int value;
  final charts.Color color;
  BarValue({this.time, this.value, this.color});
}

// ignore: must_be_immutable
class ChartsDemo extends StatefulWidget {
  final List<Transaction> transactions;

  ChartsDemo({Key key, this.transactions}) : super(key: key);

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  List<charts.Series<BarValue, DateTime>> seriesList;

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  convertToDateTime(Transaction transaction) {
    List<String> splittedDate = transaction.date.split('/');
    int day = int.tryParse(splittedDate[0]);
    int month = int.tryParse(splittedDate[1]);
    int year = int.tryParse(splittedDate[2]);
    return DateTime(year, month, day);
  }

  List<charts.Series<BarValue, DateTime>> _createRandomData() {
    final transactions = widget.transactions
        .map(
          (transaction) => BarValue(
            time: convertToDateTime(transaction),
            value: int.tryParse(transaction.price),
            color: transaction.type == '1' ? charts.MaterialPalette.green.shadeDefault : charts.MaterialPalette.red.shadeDefault,
          ),
        )
        .toList()
        .reversed
        .toList(); //to reorder transactions

    return [
      charts.Series<BarValue, DateTime>(
        id: 'Transactions monthly',
        domainFn: (BarValue transaction, _) => transaction.time,
        measureFn: (BarValue transaction, _) => transaction.value,
        data: transactions,
        fillColorFn: (BarValue transaction, _) => transaction.color,
      ),
    ];
  }

  barChart() {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: true,
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      behaviors: [
        new charts.SlidingViewport(),
        // A pan and zoom behavior helps demonstrate the sliding viewport
        // behavior by allowing the data visible in the viewport to be adjusted
        // dynamically.
        new charts.PanAndZoomBehavior(),
      ],
      domainAxis: new charts.DateTimeAxisSpec(
        tickProviderSpec: charts.AutoDateTimeTickProviderSpec(includeTime: true),
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
          day: new charts.TimeFormatterSpec(format: 'd', transitionFormat: 'dd/MM/yyyy'),
        ),
      ),
    );
    // return charts.BarChart(
    //   seriesList,
    //   animate: true,
    //   vertical: true,
    //   barGroupingType: charts.BarGroupingType.grouped,
    //   defaultRenderer: charts.BarRendererConfig(
    //     groupingType: charts.BarGroupingType.grouped,
    //   ),
    //   domainAxis: new charts.OrdinalAxisSpec(
    //     renderSpec: charts.SmallTickRendererSpec(
    //       labelRotation: -45,
    //       labelAnchor: charts.TickLabelAnchor.after,
    //       labelOffsetFromAxisPx: 50,
    //       labelOffsetFromTickPx: 50,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: state.transactionsList.isEmpty ? Center(child: Text('Bạn chưa có giao dịch nào gần đây')) : barChart(),
          );
        },
      ),
    );
  }
}
