import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/categories/categories_controller.dart';
import 'package:MoneyMe/screens/categories/components/tags_list_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TypeScreen {
  select,
  management,
  edit,
}

class CategoriesScreen extends StatelessWidget {
  final TypeScreen typeScreen;
  const CategoriesScreen({Key key, this.typeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = CategoriesController(context: context, typeScreen: typeScreen);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
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
              tabs: [
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
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TagsListView(
                tags: controller.revenues,
                onTap: controller.onSelectTag,
              ),
              TagsListView(
                onTap: controller.onSelectTag,
                tags: controller.expenses,
                jarsList: controller.jarsList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
