import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String titleBtn;
  final Color color;
  final Color colorTitle;
  final Function onPress;
  const CustomActionButton({
    Key key,
    @required this.titleBtn,
    @required this.onPress,
    this.color,
    this.colorTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Text(
          '$titleBtn',
          style: TextStyle(
            color: colorTitle,
          ),
        ),
      ),
      onPressed: onPress,
    );
  }
}
