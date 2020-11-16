import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/statistic/components/chart_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticOption extends StatefulWidget {
  @override
  _StatisticOptionState createState() => _StatisticOptionState();
}

class _StatisticOptionState extends State<StatisticOption> {
  List<String> options = ["Ngày", "Tuần", "Tháng"];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 35, maxWidth: size.width),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Color(0xffeeeeef),
            ),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPaddingHorizontal + 19.5,
                      vertical: kDefaultPaddingVertical - 5,
                    ),
                    decoration: _selectedIndex == index
                        ? BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )
                        : null,
                    child: Text(
                      options[index],
                      style: TextStyle(
                        color: _selectedIndex == index ? Colors.white : Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 30),
        Expanded(
          child: ChartsDemo(),
        ),
      ],
    );
  }
}
