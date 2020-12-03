import 'package:MoneyMe/blocs/statistic/statistic_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/statistic/components/chart_bar.dart';
import 'package:MoneyMe/screens/statistic/components/dropdown_button.dart';
import 'package:MoneyMe/screens/statistic/statistic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StatisticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StatisticController controller;
    if (controller == null) controller = StatisticController(context: context);

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
                onTap: controller.selectDateRange,
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
                  title: BlocBuilder<StatisticBloc, StatisticState>(
                    builder: (context, state) {
                      return Transform(
                        transform: Matrix4.translationValues(-20, 0.0, 0.0),
                        child: Text(
                          '${controller.formatter.format(state.startDate)} ~ ${controller.formatter.format(state.endDate)}',
                          style: kTitleTextStyle.copyWith(fontSize: 20.0),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thống kê theo ngày',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TimeRangeDropDown(
                    onPress: controller.setDateRange,
                  ),
                ],
              ),
              BlocBuilder<StatisticBloc, StatisticState>(
                builder: (context, state) {
                  return FutureBuilder<dynamic>(
                    future: controller.handleStatistic(), // async work
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Container(
                            height: 500,
                            child: Center(
                              child: ModalProgressHUD(
                                color: Colors.transparent,
                                inAsyncCall: true,
                                child: Container(),
                              ),
                            ),
                          );
                        default:
                          if (snapshot.hasError)
                            return Container(
                              height: 500,
                              child: Center(
                                child: Text(
                                  'Error: ${snapshot.error}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          else
                            return Container(
                              width: double.infinity,
                              height: 500,
                              child: Center(
                                child: Charts(
                                  transactions: snapshot.data,
                                ),
                              ),
                            );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
