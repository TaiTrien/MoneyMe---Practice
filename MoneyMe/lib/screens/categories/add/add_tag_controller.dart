import 'package:MoneyMe/api/tag_api.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/models/icon.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/screens/categories/add/icon_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTagController {
  BuildContext context;
  Tag currentTag = Tag(type: '1', jarID: '745', icon: IconsList.icons[0], parentID: '0');
  Tag parentTag;
  Jar currentJar;
  String icon;

  TextEditingController tagController = TextEditingController();
  TagBloc _tagBloc;

  AddTagController({this.context}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
    _tagBloc.add(SelectTag(currentTag));
  }

  toIconScreen() async {
    icon = await Navigator.push(context, MaterialPageRoute(builder: (context) => IconScreen()));
    currentTag.icon = icon;
    _tagBloc.add(SelectTag(currentTag));
  }

  updateParentTag(Tag newTag) {
    parentTag = newTag;
  }

  updateCurrentJar(Jar newJar) {
    currentJar = newJar;
  }

  onChanged(value) {
    currentTag.tagName = value.trim();
  }

  handleAddTag() async {
    currentTag.setJarID = currentJar.jarID;
    currentTag.setParentID = parentTag.tagID;

    var apiRespone = await TagApi.addTag(currentTag);
    if (apiRespone.code != 200) print('failed');
  }

  switchToggle() {
    if (currentTag.type == '1')
      currentTag.type = '2';
    else if (currentTag.type == '2') currentTag.type = '1';
    _tagBloc.add(SelectTag(currentTag));

    parentTag = null;
  }

  List<dynamic> get revenues => _tagBloc.state.revenues.entries.map((entry) => entry.value["parent"]).toList();
  List<dynamic> get expenses => _tagBloc.state.expenses.entries.map((entry) => entry.value["parent"]).toList();
}
