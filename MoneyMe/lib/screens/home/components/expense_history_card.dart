import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';

import '../home_controller.dart';
import 'expense_card.dart';

class ExpenseHistoryBoard extends StatelessWidget {
  final HomeController controller;
  const ExpenseHistoryBoard({
    Key key,
    @required this.size,
    @required this.controller,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: double.infinity, maxHeight: 400),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical + 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: kDefaultPaddingHorizontal),
              child: Text(
                'Lịch sử thu chi',
                style: kTitleTextStyle,
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.transactionsList.length ?? 0,
                itemBuilder: (context, index) {
                  return ExpenseCard(
                    title: controller.transactionsList[index].tagName ?? "Trống",
                    subTitle: controller.transactionsList[index].jarTitle ?? "Trống",
                    prefixMoney: (controller.transactionsList[index].type == "1") ? '+' : '-',
                    money: controller.transactionsList[index].price,
                    color: (controller.transactionsList[index].type == "1") ? Colors.green : Colors.red,
                    date: controller.transactionsList[index].date,
                    iconName: controller.transactionsList[index].icon.substring(4),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
