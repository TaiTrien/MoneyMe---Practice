import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/screens/categories/categories_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
            backgroundColor: kSecondaryColor,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: controller.tabsView,
            ),
          ),
          body: TabBarView(
            children: controller.tagsListView,
          ),
        ),
      ),
    );
  }
}
