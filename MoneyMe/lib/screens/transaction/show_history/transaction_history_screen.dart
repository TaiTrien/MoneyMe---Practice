import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/home/components/expense_card.dart';
import 'package:MoneyMe/screens/transaction/show_history/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = HistoryController(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: controller.toExit,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Lịch sử thu chi',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
      ),
      body: Container(
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return (controller.transactionList.length == 0)
                ? Center(
                    child: Text(
                    'Bạn chưa có giao dịch nào gần đây',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ))
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (controller.transactionList != null) ? controller.transactionList.length : 0,
                    itemBuilder: (context, index) {
                      var currentTransaction = controller.transactionList[index];
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
                  );
          },
        ),
      ),
    );
  }
}
