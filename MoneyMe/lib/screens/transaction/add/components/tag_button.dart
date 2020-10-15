import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TagButton extends StatelessWidget {
  final String iconName;
  final String title;
  final Function onTap;
  const TagButton({
    Key key,
    this.iconName,
    this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kPrimaryColor,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical),
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Container(
                width: 30.0,
                child: Icon(
                  MdiIcons.fromString(iconName),
                  color: kPrimaryColor,
                  size: 30.0,
                ),
              ),
              title: Align(
                alignment: Alignment(-1.5, 0),
                child: Text(
                  title,
                  style: kTitleTextStyle.copyWith(fontSize: 16.0),
                ),
              ),
            ),
          ),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
