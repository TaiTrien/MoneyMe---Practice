import 'package:MoneyMe/models/transaction.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarValue {
  final DateTime time;
  int value;
  final String type;
  final charts.Color color;
  BarValue({this.time, this.value, this.color, this.type});
}

// ignore: must_be_immutable
class Charts extends StatefulWidget {
  final List<Transaction> transactions;

  Charts({Key key, this.transactions}) : super(key: key);
  @override
  ChartsState createState() => ChartsState();
}

class ChartsState extends State<Charts> {
  List<charts.Series<BarValue, DateTime>> seriesList;

  @override
  void initState() {
    super.initState();
    seriesList = _createData();
  }

  convertToDateTime(String transactionDate) {
    List<String> splittedDate = transactionDate.split('-');
    int day = int.tryParse(splittedDate[0]);
    int month = int.tryParse(splittedDate[1]);
    int year = int.tryParse(splittedDate[2]);
    return DateTime(year, month, day);
  }

  List<charts.Series<BarValue, DateTime>> _createData() {
    List<BarValue> revenues = List<BarValue>();
    List<BarValue> expenses = List<BarValue>();

    Map<String, BarValue> mapRevenues = Map<String, BarValue>();
    Map<String, BarValue> mapExpenses = Map<String, BarValue>();

    for (int i = 0; i < widget.transactions.length; i++) {
      Transaction transaction = widget.transactions[i];
      String date = transaction.date;
      String type = transaction.type;

      if (type == '1') {
        if (mapRevenues.containsKey(date)) {
          mapRevenues[date].value += int.tryParse(transaction.price);
        } else {
          mapRevenues[date] = BarValue(
            time: convertToDateTime(date),
            value: int.tryParse(
              transaction.price,
            ),
            type: transaction.type,
            color: transaction.type == '1' ? charts.MaterialPalette.green.shadeDefault : charts.MaterialPalette.red.shadeDefault,
          );
        }
      } else {
        if (mapExpenses.containsKey(date)) {
          mapExpenses[date].value += int.tryParse(transaction.price);
        } else {
          mapExpenses[date] = BarValue(
            time: convertToDateTime(date),
            value: int.tryParse(
              transaction.price,
            ),
            type: transaction.type,
            color: transaction.type == '1' ? charts.MaterialPalette.green.shadeDefault : charts.MaterialPalette.red.shadeDefault,
          );
        }
      }
    }
    BarValue defaultValueRevenue = BarValue(
      time: DateTime(DateTime.now().year, DateTime.now().month, 1),
      value: 0,
      color: charts.MaterialPalette.green.shadeDefault,
    );
    BarValue defaultValueExpense = BarValue(
      time: DateTime(DateTime.now().year, DateTime.now().month, 1),
      value: 0,
      color: charts.MaterialPalette.red.shadeDefault,
    );

    if (mapRevenues.length == 1) {
      revenues.add(defaultValueRevenue);
    }
    mapRevenues.entries.forEach((element) {
      revenues.add(element.value);
    });

    if (mapExpenses.length == 1) {
      expenses.add(defaultValueExpense);
    }
    mapExpenses.entries.forEach((element) {
      expenses.add(element.value);
    });

    return [
      charts.Series<BarValue, DateTime>(
        id: 'Mức thu',
        domainFn: (BarValue transaction, _) => transaction.time,
        measureFn: (BarValue transaction, _) => transaction.value,
        data: revenues,
        colorFn: (BarValue transaction, _) => transaction.color,
      ),
      charts.Series<BarValue, DateTime>(
        id: 'Mức chi',
        domainFn: (BarValue transaction, _) => transaction.time,
        measureFn: (BarValue transaction, _) => transaction.value,
        data: expenses,
        colorFn: (BarValue transaction, _) => transaction.color,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    lineChart() {
      return new charts.TimeSeriesChart(
        seriesList,
        animate: true,
        defaultRenderer: charts.LineRendererConfig<DateTime>(),
        primaryMeasureAxis: new charts.NumericAxisSpec(),
        behaviors: [
          new charts.SeriesLegend(),
        ],
        domainAxis: charts.DateTimeAxisSpec(
          tickProviderSpec: charts.AutoDateTimeTickProviderSpec(includeTime: false),
          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
            day: charts.TimeFormatterSpec(
              format: 'dd/MM/yyyy',
              transitionFormat: 'dd/MM/yyyy',
            ),
            hour: charts.TimeFormatterSpec(
              format: '',
              transitionFormat: 'dd/MM/yyyy',
            ),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: widget.transactions.isEmpty
            ? Center(
                child: Text(
                  'Bạn chưa có giao dịch nào lúc này',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : lineChart(),
      ),
    );
  }
}
