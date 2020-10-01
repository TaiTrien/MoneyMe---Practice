import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';

class InkWellBtn extends StatelessWidget {
  final String titleBtn;
  final Color spashColor;
  final Function onTap;
  const InkWellBtn({
    Key key,
    @required this.titleBtn,
    @required this.onTap,
    this.spashColor = kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: spashColor,
        onTap: onTap,
        child: Row(
          children: [
            Icon(Icons.navigate_next),
            Container(
              padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical),
              child: Text(
                titleBtn,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
