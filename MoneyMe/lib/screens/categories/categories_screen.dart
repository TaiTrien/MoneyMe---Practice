import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/change_password/change_password_controller.dart';
import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = ChangePasswordController();
    return MaterialApp(
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
              tabs: [
                Tab(
                  text: 'Khoản thu',
                ),
                Tab(
                  text: 'Khoản chi',
                ),
              ],
            ),
          ),
          body: Container(),
        ),
      ),
    );
  }
}
