import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/dashboard/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'components/expense_history_card.dart';
import 'components/jars_list_board.dart';
import 'components/remain_money_card.dart';

class HomeScreen extends StatelessWidget {
  final dynamic userInfo;
  final dynamic jarsList;
  final dynamic expenseHistory;

  const HomeScreen({Key key, this.userInfo, this.jarsList, this.expenseHistory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = HomeController(userInfo: userInfo, jarsList: jarsList, expenseHistory: expenseHistory);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/icons/menu.svg'),
                    Text(
                      'Hi ${controller.userName}',
                      style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                    ),
                    SvgPicture.asset(
                      'assets/icons/search.svg',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              RemainMoneyCard(
                controller: controller,
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFf7f9fc),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      ExpenseHistoryBoard(
                        size: size,
                        controller: controller,
                      ),
                      SizedBox(height: 10.0),
                      JarsListBoard(
                        size: size,
                        controller: controller,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
