import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/screens/categories/components/tag_row.dart';
import 'package:flutter/material.dart';

class TagsListView extends StatelessWidget {
  final List<Tag> tagsList;

  const TagsListView({
    Key key,
    @required this.tagsList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: tagsList.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: kPrimaryColor,
                  height: 20,
                  thickness: 2,
                  endIndent: kDefaultPaddingHorizontal,
                  indent: kDefaultPaddingHorizontal,
                );
              },
              itemBuilder: (context, index) {
                return JarRow(
                  title: tagsList[index].tagName,
                  jarName: 'NEC',
                  iconName: tagsList[index].icon.substring(4),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
