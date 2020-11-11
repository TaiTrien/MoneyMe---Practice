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

class EditTagController {
  BuildContext context;
  Tag currentTag;
  Tag parentTag;
  Jar currentJar;

  String icon;
  Notify notify = Notify();

  TextEditingController tagController = TextEditingController();
  TagBloc _tagBloc;

  EditTagController({this.context}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
    _tagBloc.add(SelectTag(currentTag));

    currentTag = _tagBloc.state.selectedTag;
    if (currentTag.parentID != '0') {
      parentTag = _tagBloc.state.tagsList.firstWhere((tag) => (tag.tagID == currentTag.parentID));
    }
    tagController.text = currentTag.tagName;
  }

  handleEditTag() async {
    currentTag.setTagName = tagController.text.trim();
    if (currentTag.tagName.isEmpty) return notify.error(message: 'Vui lòng thêm tên');
    if (currentTag.type == '2' && currentJar == null) {
      Notify().error(message: 'Vui lòng thêm hũ');
      return;
    }
    currentTag.setJarID = (currentJar != null) ? currentJar.jarID : '745';
    currentTag.setParentID = (parentTag != null) ? parentTag.tagID : '0';

    Navigator.pop(context);

    var apiRespone = await TagApi.editTag(currentTag);

    if (apiRespone.code != 200) return notify.error(message: 'Sửa hạng mục thất bại');
    notify.success(message: 'Sửa hạng mục thành công');
    await editSuccessfully();
  }

  editSuccessfully() async {
    await loadTagsData();
    _tagBloc.add(ResetSelectedTag(null));
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

    _tagBloc.add(LoadingTagsData(tagsList));
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

  List<dynamic> get revenues {
    List<dynamic> revenues = _tagBloc.state.revenues.entries.map((entry) => entry.value["parent"]).toList();
    revenues.removeWhere((tag) => tag.tagID == currentTag.tagID);
    return revenues;
  }

  List<dynamic> get expenses {
    List<dynamic> expenses = _tagBloc.state.expenses.entries.map((entry) => entry.value["parent"]).toList();
    expenses.removeWhere((tag) => tag.tagID == currentTag.tagID);
    return expenses;
  }
}
