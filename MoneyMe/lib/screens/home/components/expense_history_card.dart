import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          return Container(
            height: (state.transactionsList.length == 0) ? 100 : state.transactionsList.length * 90.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Lịch sử thu chi',
                        style: kTitleTextStyle,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: controller.toTransactionHistoryScreen,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical),
                                child: Text(
                                  'Xem tất cả',
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: kSecondaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: (state.transactionsList.length == 0)
                      ? Center(
                          child: Text(
                            'Chưa có giao dịch gần đây',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (state.transactionsList != null) ? state.transactionsList.length : 0,
                          itemBuilder: (context, index) {
                            var currentTransaction = state.transactionsList[index];
                            return GestureDetector(
                              onTap: () => controller.toEditTransactionScreen(currentTransaction),
                              child: ExpenseCard(
                                title: currentTransaction.tagName ?? "Trống",
                                subTitle: currentTransaction.jarTitle ?? "Trống",
                                prefixMoney: (currentTransaction.type == "1") ? '+' : '-',
                                money: currentTransaction.price,
                                color: (currentTransaction.type == "1") ? kPrimaryColor : Colors.red,
                                date: currentTransaction.date,
                                iconName: currentTransaction.icon.substring(4),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
