import 'package:flutter/material.dart';

class Services {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();
  }

  static void showKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();
  }
}
