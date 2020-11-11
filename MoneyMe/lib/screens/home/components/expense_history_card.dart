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
      constraints: BoxConstraints(maxWidth: double.infinity, maxHeight: 200),
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          return Container(
            height: (state.transactionsList.length == 0) ? 200 : state.transactionsList.length * 100.0,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical),
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
                  child: (state.transactionsList.length == 0)
                      ? Center(
                          child: Text(
                            'Chưa có giao dịch gần đây',
                            style: kTitleTextStyle.copyWith(color: Colors.grey),
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
          );
        },
      ),
    );
  }
}
