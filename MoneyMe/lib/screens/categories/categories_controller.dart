import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/screens/categories/add/add_tag_controller.dart';
import 'package:MoneyMe/screens/categories/add/add_tag_screen.dart';
import 'package:MoneyMe/screens/categories/categories_screen.dart';
import 'package:MoneyMe/screens/categories/components/tags_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesController {
  BuildContext context;
  TypeScreen typeScreen;
  Transaction currentTransaction;
  // ignore: close_sinks
  TagBloc _tagBloc;
  // ignore: close_sinks
  JarBloc _jarBloc;

  List<Tag> tagsList;
  List<Jar> jarsList;
  List<TagsListView> tagsListViews;
  List<Tab> tabs;

  var revenueMap = Map<int, Map<String, dynamic>>();
  var expenseMap = Map<int, Map<String, dynamic>>();

  CategoriesController({this.context, this.typeScreen, this.currentTransaction}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);

    tagsList = _tagBloc.state.tagsList;
    jarsList = _jarBloc.state.jarsList;
    // seperateTagsList();

    tabs = [
      Tab(
        child: Text(
          'Khoản thu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      Tab(
        child: Text(
          'Khoản chi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    ];
  }

  toAddTagScreen() {
    AddTagController controller = AddTagController(context: context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTagScreen(),
      ),
    );
  }

  onSelectTag(Tag tag) {
    if (typeScreen == TypeScreen.select) {
      _tagBloc.add(SelectTag(tag));
      Navigator.pop(context);
    } else if (typeScreen == TypeScreen.edit) {
      //push tag to edit transaction screen
      Navigator.pop(context, tag);
    } else if (typeScreen == TypeScreen.management) {
      _tagBloc.add(SelectTag(tag));
      Navigator.pushNamed(context, '/editTagScreen');
    }
  }

  get tabsView {
    tagsListViews = [
      TagsListView(
        tags: _tagBloc.state.revenues,
        onTap: onSelectTag,
      ),
      TagsListView(
        onTap: onSelectTag,
        tags: _tagBloc.state.expenses,
        jarsList: jarsList,
      )
    ];

    if (typeScreen != TypeScreen.edit) return tabs;

    if (currentTransaction.type == '1') return [tabs[0]];
    return [tabs[1]];
  }

  get tagsListView {
    if (typeScreen != TypeScreen.edit) return tagsListViews;

    if (currentTransaction.type == '1') return [tagsListViews[0]];
    return [tagsListViews[1]];
  }
}
