import 'package:MoneyMe/api/tag_api.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
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
    currentTag.setParentID = null;
    _tagBloc.add(SelectTag(currentTag));
  }

  updateCurrentJar(Jar newJar) {
    currentJar = newJar;
  }

  onChanged(value) {
    currentTag.tagName = value.trim();
  }

  handleAddTag() async {
    if (currentTag.tagName == null) return Notify().error(message: 'Vui lòng thêm tên');
    if (currentTag.type == '2' && currentJar == null) return Notify().error(message: 'Vui lòng thêm hũ');

    currentTag.setJarID = (currentJar != null) ? currentJar.jarID : '745';
    currentTag.setParentID = (parentTag != null) ? parentTag.tagID : '0';

    var apiRespone = await TagApi.addTag(currentTag);
    if (apiRespone.code != 200) return Notify().error(message: 'Thêm thất bại');
    addSuccessfully();
  }

  addSuccessfully() async {
    await loadTagsData();
    Navigator.pop(context);
  }

  Future<void> loadTagsData() async {
    var tagsListData = await TagApi.getTagsList();
    List<Tag> tagsList = List<Tag>();

    int tagsListLength = tagsListData.data.length;

    for (int i = 0; i < tagsListLength; i++) {
      Tag newTag = Tag.map(tagsListData.data[i]);

      if (!IconsList.icons.contains(newTag.icon)) IconsList.icons.add(newTag.icon);

      tagsList.add(newTag);
    }
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
