import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TagRowChild extends StatelessWidget {
  final String title;
  final String jarName;
  final String iconName;
  final Color color;
  final String prefixMoney;
  const TagRowChild({
    Key key,
    @required this.title,
    @required this.iconName,
    this.color,
    this.prefixMoney,
    this.jarName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Container(
          padding: EdgeInsets.only(left: 60),
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
            trailing: Text(
              jarName,
              style: kSubTitleTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
