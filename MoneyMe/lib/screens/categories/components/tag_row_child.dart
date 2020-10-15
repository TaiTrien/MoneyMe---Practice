import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TagRowChild extends StatelessWidget {
  final String title;
  final String jarName;
  final String iconName;
  final Color color;
  final Function onTap;
  const TagRowChild({
    Key key,
    @required this.title,
    @required this.iconName,
    this.color,
    this.jarName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Container(
          padding: EdgeInsets.only(left: 40),
          child: ListTile(
            onTap: onTap,
            contentPadding: EdgeInsets.only(right: 12),
            leading: Container(
              height: double.infinity,
              width: 30.0,
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
