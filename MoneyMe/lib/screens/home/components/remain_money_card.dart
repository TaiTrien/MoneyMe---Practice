import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/home/home_controller.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemainMoneyCard extends StatelessWidget {
  final HomeController controller;
  const RemainMoneyCard({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical + 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: BlocBuilder<JarBloc, JarState>(
          builder: (context, state) {
            return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Số tiền hiện tại \n',
                    style: kSubTitleTextStyle,
                  ),
                  TextSpan(
                    text: Formatter.formatMoney(state.remainMoney).toString(),
                    style: kTitleTextStyle.copyWith(fontSize: 25.0),
                  ),
                  TextSpan(
                    text: ' VND',
                    style: kTitleTextStyle,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
