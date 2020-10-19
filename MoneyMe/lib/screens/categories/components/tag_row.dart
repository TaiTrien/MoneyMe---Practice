import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/screens/categories/components/tag_row_child.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TagRow extends StatelessWidget {
  final String jarName;
  final Tag tagParent;

  final List<Tag> childTagsList;
  final List<Jar> jarsList;

  const TagRow({
    Key key,
    this.childTagsList,
    this.jarsList,
    this.jarName,
    this.tagParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TagBloc _tagBloc = BlocProvider.of<TagBloc>(context);
    return Card(
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                _tagBloc.add(SelectTag(tagParent));
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              leading: Container(
                height: double.infinity,
                width: 30.0,
                child: Icon(
                  MdiIcons.fromString(tagParent.icon.substring(4)),
                  color: kPrimaryColor,
                  size: 30.0,
                ),
              ),
              title: Text(
                tagParent.tagName,
                style: kTitleTextStyle.copyWith(fontSize: 16.0),
              ),
              trailing: Text(
                jarName,
                style: kSubTitleTextStyle,
              ),
            ),
            Container(
              child: ListBody(
                mainAxis: Axis.vertical,
                children: childTagsList
                    .map(
                      (tag) => TagRowChild(
                        onTap: () {
                          _tagBloc.add(SelectTag(tag));
                        },
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
          ],
        ),
      ),
    );
  }
}
