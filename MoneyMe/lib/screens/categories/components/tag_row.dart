import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/screens/categories/components/tag_row_child.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TagRow extends StatelessWidget {
  final String title;
  final String iconName;
  final String jarName;

  final List<Tag> childTagsList;
  final List<Jar> jarsList;
  const TagRow({
    Key key,
    @required this.title,
    @required this.iconName,
    this.childTagsList,
    this.jarsList,
    this.jarName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
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
          children: childTagsList
              .map(
                (tag) => TagRowChild(
                  title: tag.tagName,
                  jarName: (jarsList == null)
                      ? ''
                      : jarsList
                          .singleWhere(
                            (jar) => (jar.jarID == tag.jarID),
                          )
                          .jarName,
                  iconName: tag.icon.substring(4),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
