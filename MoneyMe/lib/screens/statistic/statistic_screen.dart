import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/statistic/components/chart_bar.dart';
import 'package:MoneyMe/screens/statistic/statistic_controller.dart';
import 'package:flutter/material.dart';

class StatisticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = StatisticController(context: context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Thống kê tài chính',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingHorizontal,
            vertical: kDefaultPaddingVertical + 10,
          ),
          width: double.infinity,
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.handleStatistic,
                child: ListTile(
                  dense: true,
                  leading: Container(
                    height: double.infinity,
                    width: 30.0,
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.calendar_today,
                      color: kPrimaryColor,
                      size: 30.0,
                    ),
                  ),
                  title: Transform(
                    transform: Matrix4.translationValues(-20, 0.0, 0.0),
                    child: Text(
                      '15 feb, 2020',
                      style: kTitleTextStyle.copyWith(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Thống kê theo ngày',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                width: double.infinity,
                height: 500,
                child: ChartsDemo(
                  transactions: controller.transactions,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
