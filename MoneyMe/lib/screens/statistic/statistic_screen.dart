import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/statistic/components/statistic_option.dart';
import 'package:flutter/material.dart';

class StatisticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thống kê tài chính',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
        width: double.infinity,
        child: Column(
          children: [
            GestureDetector(
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffeeeeef),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: StatisticOption(),
            ),
          ],
        ),
      ),
    );
  }
}