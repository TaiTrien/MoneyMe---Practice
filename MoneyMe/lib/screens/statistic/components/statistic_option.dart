import 'package:MoneyMe/constants.dart';
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
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 35, maxWidth: size.width),
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
    );
  }
}
