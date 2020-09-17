import 'package:flutter/material.dart';

class CustomDiaglog extends StatelessWidget {
  final Widget titleWidget;
  final List<Widget> actions;
  final String content;
  final Function onPress;
  const CustomDiaglog({
    Key key,
    this.actions,
    this.content,
    this.onPress,
    this.titleWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      title: titleWidget,
      content: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      elevation: 24.0,
    );
  }
}
