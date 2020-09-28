import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/home/home_controller.dart';
import 'package:MoneyMe/utils/formater.dart';
import 'package:flutter/material.dart';

class RemainMoneyCard extends StatelessWidget {
  final HomeController controller;
  const RemainMoneyCard({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical + 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Số tiền hiện tại trong ví\n',
                style: kSubTitleTextStyle,
              ),
              TextSpan(
                text: Formatter.formatMoney(controller.totalExpense),
                style: kTitleTextStyle.copyWith(fontSize: 25.0),
              ),
              TextSpan(
                text: ' VND',
                style: kTitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
