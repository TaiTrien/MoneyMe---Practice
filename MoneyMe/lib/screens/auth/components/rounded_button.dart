import 'package:flutter/material.dart';

class RoudedButton extends StatelessWidget {
  final String titleBtn;
  final Function onPressed;
  const RoudedButton({
    Key key,
    @required this.titleBtn,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        onPressed: onPressed,
        child: Text(
          '$titleBtn',
          style: TextStyle(color: Colors.white),
        ),
        color: Color(0xFF4dc9cb),
      ),
    );
  }
}
