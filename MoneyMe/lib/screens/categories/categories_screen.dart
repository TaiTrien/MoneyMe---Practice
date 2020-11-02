import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/screens/categories/categories_controller.dart';
import 'package:MoneyMe/screens/categories/components/tags_list_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TypeScreen {
  select,
  management,
  edit,
}

class CategoriesScreen extends StatelessWidget {
  final TypeScreen typeScreen;
  final Transaction currentTransaction;
  const CategoriesScreen({Key key, this.typeScreen, this.currentTransaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = CategoriesController(context: context, typeScreen: typeScreen, currentTransaction: currentTransaction);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: (typeScreen == TypeScreen.edit) ? 1 : 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: (typeScreen == TypeScreen.select)
                ? FlatButton(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  )
                : null,
            title: Text(
              (typeScreen == TypeScreen.management) ? 'Quản lý danh mục' : 'Chọn hạng mục',
              style: kTitleTextStyle.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            actions: (typeScreen == TypeScreen.management)
                ? [
                    FlatButton(
                      child: Icon(Icons.add, color: Colors.white),
                      onPressed: controller.toAddTagScreen,
                    )
                  ]
                : [],
            backgroundColor: kSecondaryColor,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: controller.tabsView,
            ),
          ),
          body: BlocBuilder<TagBloc, TagState>(
            builder: (context, state) {
              return TabBarView(
                children: (typeScreen != TypeScreen.edit)
                    ? ([
                        TagsListView(
                          tags: state.revenues,
                          onTap: controller.onSelectTag,
                        ),
                        TagsListView(
                          onTap: controller.onSelectTag,
                          tags: state.expenses,
                          jarsList: controller.jarsList,
                        )
                      ])
                    : (currentTransaction.type == '1')
                        ? TagsListView(
                            tags: state.revenues,
                            onTap: controller.onSelectTag,
                          )
                        : TagsListView(
                            onTap: controller.onSelectTag,
                            tags: state.expenses,
                            jarsList: controller.jarsList,
                          ),
                //children: controller.tagsListView,
              );
            },
          ),
        ),
      ),
    );
  }
}
