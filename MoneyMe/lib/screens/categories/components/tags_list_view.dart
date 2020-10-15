import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/screens/categories/components/tag_row.dart';
import 'package:flutter/material.dart';

class TagsListView extends StatelessWidget {
  final Map<int, Map<String, dynamic>> tags;
  final List<Jar> jarsList;
  const TagsListView({
    Key key,
    @required this.tags,
    this.jarsList,
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
              separatorBuilder: (context, index) {
                return Divider(
                  color: kPrimaryColor,
                  height: 20,
                  thickness: 2,
                  endIndent: kDefaultPaddingHorizontal,
                  indent: kDefaultPaddingHorizontal,
                );
              },
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return TagRow(
                  title: tags[index]['parent'].tagName,
                  jarName: (jarsList == null)
                      ? ''
                      : jarsList
                          .singleWhere(
                            (jar) => (jar.jarID == tags[index]['parent'].jarID),
                          )
                          .jarName,
                  iconName: tags[index]['parent'].icon.substring(4),
                  childTagsList: tags[index]['children'],
                  jarsList: jarsList,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
