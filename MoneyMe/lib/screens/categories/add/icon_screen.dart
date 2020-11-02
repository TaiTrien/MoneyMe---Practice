import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/icon.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10,
        runSpacing: kDefaultPaddingVertical,
        children: IconsList.icons
            .map((icon) => GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    child: Icon(
                      MdiIcons.fromString(icon.substring(4)),
                      color: Colors.white,
                    ))))
            .toList(),
      ),
    );
  }
}
