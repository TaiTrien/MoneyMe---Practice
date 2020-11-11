import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String titleBtn;
  final Function onPressed;
  const DefaultButton({
    Key key,
    @required this.titleBtn,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPaddingVertical,
        horizontal: 10,
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(),
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPaddingVertical,
        ),
        onPressed: onPressed,
        child: Text(
          '$titleBtn',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        color: kPrimaryColor,
      ),
    );
  }
}
