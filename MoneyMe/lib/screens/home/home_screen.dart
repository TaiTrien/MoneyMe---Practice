import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/home/home_controller.dart';
import 'package:flutter/material.dart';

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
    var controller = HomeController(context: context);
    var size = MediaQuery.of(context).size;

    return Material(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        body: Container(
          color: kPrimaryColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: kDefaultPaddingVertical + 10),
                child: Text(
                  'Chào ${controller.userName}',
                  style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                ),
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
                  padding: EdgeInsets.only(right: 25.0, left: 25.0, top: 25.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFf7f9fc),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ExpenseHistoryBoard(
                          size: size,
                          controller: controller,
                        ),
                        SizedBox(height: 20.0),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: double.infinity, maxHeight: 320),
                          child: JarsListBoard(
                            size: size,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
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
