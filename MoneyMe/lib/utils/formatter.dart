import 'package:intl/intl.dart';

class Formatter {
  static final currencyFormat = new NumberFormat("#,##0", "en_US");
  static final dateFormat = new DateFormat("dd-MM-yyyy");

  static formatMoney(dynamic money) {
    try {
      return currencyFormat.format(int.tryParse("$money"));
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
    return dateFormat.format(date);
  }
}
