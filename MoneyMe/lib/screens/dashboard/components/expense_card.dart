import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpenseCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String money;
  final String date;
  final String iconPath;
  const ExpenseCard({
    Key key,
    @required this.title,
    @required this.iconPath,
    @required this.money,
    this.subTitle,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Container(
          height: double.infinity,
          width: 30.0,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconPath,
            color: kHeaderColor,
          ),
        ),
        title: Text(
          title,
          style: kTitleTextStyle.copyWith(fontSize: 16.0),
        ),
        subtitle: Text(
          subTitle,
          style: kSubTitleTextStyle,
        ),
        trailing: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$money vnd\n',
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(
                text: date,
                style: kSubTitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
