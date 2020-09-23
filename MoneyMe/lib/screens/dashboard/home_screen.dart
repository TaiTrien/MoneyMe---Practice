import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/dashboard/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/expense_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = new HomeController();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/icons/menu.svg'),
                    Text(
                      'Hi Chien',
                      style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                    ),
                    SvgPicture.asset(
                      'assets/icons/search.svg',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical + 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Số tiền hiện tại trong ví\n',
                          style: kSubTitleTextStyle,
                        ),
                        TextSpan(
                          text: '158,583,000',
                          style: kTitleTextStyle.copyWith(fontSize: 25.0),
                        ),
                        TextSpan(
                          text: ' VND',
                          style: kTitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFf7f9fc),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical + 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lịch sử thu chi',
                          style: kTitleTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ExpenseCard(
                          title: 'Ăn uống',
                          subTitle: 'Chi tiêu thiết yếu',
                          money: '-20,000',
                          date: '23/09/2020',
                          iconPath: 'assets/icons/menu.svg',
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                        ),
                        ExpenseCard(
                          title: 'Ăn uống',
                          subTitle: 'Chi tiêu thiết yếu',
                          money: '-20,000',
                          date: '23/09/2020',
                          iconPath: 'assets/icons/menu.svg',
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
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
