import 'dart:collection';

import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class CategoriesController {
  BuildContext context;
  TagBloc _tagBloc;
  JarBloc _jarBloc;

  List<Tag> tagsList;
  List<Jar> jarsList;

  var tagMap = Map<int, Map<String, dynamic>>();
  var revenueMap = Map<int, Map<String, dynamic>>();
  var expenseMap = Map<int, Map<String, dynamic>>();

  CategoriesController({this.context}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);

    tagsList = _tagBloc.state.tagsList;
    jarsList = _jarBloc.state.jarsList;
    seperateTagsList();
  }

  getChildTagsList() {
    var childTagsList = List<Tag>();

    for (int i = 0; i < tagsList.length; i++) {
      String parentID = tagsList[i].parentID;

      if (parentID != '0') {
        childTagsList.add(tagsList[i]);
      }
    }
    return childTagsList;
  }

  seperateTagsList() {
    var childTagsList = getChildTagsList();
    int indexRevenue = 0;
    int indexExpense = 0;

    for (int i = 0; i < tagsList.length; i++) {
      String parentID = tagsList[i].parentID;

      if (parentID == '0') {
        String tagID = tagsList[i].tagID;
        if (tagsList[i].type == '1') {
          revenueMap[indexRevenue] = {
            'parent': tagsList[i],
            'children': childTagsList.where((tag) => (tag.parentID == tagID)).toList(),
          };
          indexRevenue++;
        } else if (tagsList[i].type == '2') {
          expenseMap[indexExpense] = {
            'parent': tagsList[i],
            'children': childTagsList.where((tag) => (tag.parentID == tagID)).toList(),
          };
          indexExpense++;
        }
        tagMap[i] = {
          'parent': tagsList[i],
          'children': childTagsList.where((tag) => (tag.parentID == tagID)).toList(),
        };
      }
    }
  }

  get seperatedTagsList => this.tagMap;
  get revenues => this.revenueMap;
  get expenses => this.expenseMap;
}
