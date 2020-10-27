import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/screens/categories/components/tag_row.dart';
import 'package:flutter/material.dart';

class TagsListView extends StatelessWidget {
  final Map<int, Map<String, dynamic>> tags;
  final List<Jar> jarsList;

  final Function onTap;
  const TagsListView({
    Key key,
    @required this.tags,
    this.jarsList,
    this.onTap,
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
                  onTap: onTap,
                  tagParent: tags[index]['parent'],
                  jarName: (jarsList == null)
                      ? ''
                      : jarsList
                          .singleWhere(
                            (jar) => (jar.jarID == tags[index]['parent'].jarID),
                          )
                          .jarName,
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
