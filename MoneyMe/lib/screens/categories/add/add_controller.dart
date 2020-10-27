import 'package:MoneyMe/api/tag_api.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:flutter/cupertino.dart';

class AddTagController {
  BuildContext context;
  AddTagController({this.context});

  handleAddTag() async {
    Tag newTag = new Tag(
      icon: "mdi-cash-usd-outline",
      jarID: "745",
      parentID: "2252",
      tagName: "Cơm trưa",
      type: '2',
    );
    TagApi.addTag(newTag);
  }
}
