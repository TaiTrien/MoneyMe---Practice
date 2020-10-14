import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/categories/categories_controller.dart';
import 'package:MoneyMe/screens/categories/components/tags_list_view.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = CategoriesController(context: context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: FlatButton(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Chọn hạng mục',
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
                tagsList: controller.revenues,
                // childTagsList: controller.childTags,
                //jarNames: controller.expenseJarName(),
              ),
              TagsListView(
                tagsList: controller.expenses,
                // childTagsList: controller.childTags,
                //jarNames: controller.expenseJarName(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
