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
      constraints: BoxConstraints(maxWidth: double.infinity, maxHeight: size.height * 0.4),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical + 10),
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
                shrinkWrap: true,
                itemCount: 1000,
                itemBuilder: (context, index) {
                  return ExpenseCard(
                    title: 'Ăn uống',
                    subTitle: 'Chi tiêu thiết yếu',
                    money: '-20,000',
                    date: '23/09/2020',
                    iconPath: 'assets/icons/menu.svg',
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
