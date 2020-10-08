import 'package:intl/intl.dart';

class Formatter {
  static final currencyFormat = new NumberFormat("#,##0", "en_US");
  static final format = new DateFormat("dd-MM-yyyy");

  static formatMoney(dynamic money) {
    try {
      return currencyFormat.format(int.parse("$money"));
    } catch (e) {
      print(e);
    }
  }

  static formatDate(dynamic unixTime) {
    var date;
    try {
      date = new DateTime.fromMillisecondsSinceEpoch(int.parse(unixTime) * 1000);
    } catch (e) {
      print(e);
    }
    return format.format(date);
  }
}
