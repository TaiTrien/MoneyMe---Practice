import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Notify {
  success({String message, int timeout = 5}) {
    this.show(message: message, color: Color(0xFF83b535), timeout: timeout);
  }

  error({String message, int timeout = 5}) {
    this.show(message: message, color: Colors.red, timeout: timeout);
  }

  light({String message, int timeout = 5}) {
    this.show(message: message, color: Color(0xFF9199a1), timeout: timeout);
  }

  show({String message, Color color, fontColor = Colors.white, int timeout}) {
    try {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {}
  }
}
