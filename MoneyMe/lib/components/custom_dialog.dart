import 'package:flutter/material.dart';

class CustomDiaglog extends StatelessWidget {
  final Widget titleWidget;
  final List<Widget> actions;
  final String title;
  final String subTitle;
  final Function onPress;
  const CustomDiaglog({
    Key key,
    this.actions,
    this.title,
    this.onPress,
    this.titleWidget,
    this.subTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      title: titleWidget,
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: title + '\n',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 28,
              ),
            ),
            TextSpan(
              text: '\n' + subTitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      actions: actions,
      elevation: 24.0,
    );
  }
}
