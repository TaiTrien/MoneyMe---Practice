import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class JarCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String iconName;

  const JarCard({
    Key key,
    @required this.title,
    @required this.iconName,
    this.subTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
