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
                itemCount: (controller.transactionsList != null) ? controller.transactionsList.length : 0,
                itemBuilder: (context, index) {
                  var currentTransaction = controller.transactionsList[index];
                  return GestureDetector(
                    onTap: () => controller.toEditTransactionScreen(currentTransaction),
                    child: ExpenseCard(
                      title: currentTransaction.tagName ?? "Trống",
                      subTitle: currentTransaction.jarTitle ?? "Trống",
                      prefixMoney: (currentTransaction.type == "1") ? '+' : '-',
                      money: currentTransaction.price,
                      color: (currentTransaction.type == "1") ? Colors.green[400] : Colors.red,
                      date: currentTransaction.date,
                      iconName: currentTransaction.icon.substring(4),
                    ),
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
