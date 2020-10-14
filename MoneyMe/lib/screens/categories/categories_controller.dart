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

  Function eq = const DeepCollectionEquality().equals;

  List<Tag> tagsList;
  List<Jar> jarsList;
  List<Tag> revenueList = List<Tag>();
  List<Tag> expenseList = List<Tag>();
  List<Tag> childTagsList = List<Tag>();

  CategoriesController({this.context}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);

    tagsList = _tagBloc.state.tagsList;
    jarsList = _jarBloc.state.jarsList;
    seperateTagsList();
  }

  seperateTagsList() {
    var mapTag = Map<String, Map<String, dynamic>>();

    for (int i = 0; i < tagsList.length; i++) {
      String parentID = tagsList[i].parentID;
      List<Tag> childTags = new List<Tag>();

      if (parentID == '0') {
        String tagID = tagsList[i].tagID;

        mapTag[tagID] = {
          'parent': tagsList[i],
          'children': childTags,
        };
      } else {
        childTags.add(tagsList[i]);
        mapTag[parentID] = {
          'parent': mapTag[parentID],
          'children': childTags,
        };
      }
    }
    print(tagsList.length);
    print(mapTag.length);
    print(mapTag['2247']['parent'].tagID);
  }

  get revenues => this.revenueList;
  get expenses => this.expenseList;
  get jars => this.jarsList;
}
