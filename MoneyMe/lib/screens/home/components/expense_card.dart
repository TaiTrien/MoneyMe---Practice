import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ExpenseCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String money;
  final String date;
  final String iconName;
  final Color color;
  final String prefixMoney;
  const ExpenseCard({
    Key key,
    @required this.title,
    @required this.iconName,
    @required this.money,
    this.subTitle,
    this.date,
    this.color,
    this.prefixMoney,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Container(
          height: double.infinity,
          width: 30.0,
          alignment: Alignment.centerLeft,
          child: Icon(
            MdiIcons.fromString(iconName),
            color: kPrimaryColor,
            size: 30.0,
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
                text: prefixMoney + Formatter.formatMoney(this.money) + " vnd\n",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: Formatter.formatDate(date).toString(),
                style: kSubTitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
