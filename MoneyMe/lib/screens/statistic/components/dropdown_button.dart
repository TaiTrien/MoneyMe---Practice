import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';

class TimeRangeDropDown extends StatefulWidget {
  final Function onPress;
  TimeRangeDropDown({Key key, this.onPress}) : super(key: key);

  @override
  _TimeRangeDropDownState createState() => _TimeRangeDropDownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _TimeRangeDropDownState extends State<TimeRangeDropDown> {
  DateRange dropdownValue;
  Map<DateRange, String> dictionary = {
    DateRange.ThisWeek: 'Tuần này',
    DateRange.LastWeek: 'Tuần trước',
    DateRange.ThisMonth: 'Tháng này',
    DateRange.LastMonth: 'Tháng trước',
    DateRange.ThisQuarter: 'Quý này',
    DateRange.LastQuarter: 'Quý trước',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.black45,
            offset: Offset(0, 2),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButton<DateRange>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down, color: kPrimaryColor),
        iconSize: 24,
        elevation: 16,
        underline: Container(height: 2, color: Colors.transparent),
        hint: Text(
          'Chọn khoảng thời gian',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: kPrimaryColor,
            fontSize: 16,
          ),
        ),
        style: TextStyle(color: kPrimaryColor),
        onChanged: (DateRange newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <DateRange>[
          DateRange.ThisWeek,
          DateRange.LastWeek,
          DateRange.ThisMonth,
          DateRange.LastMonth,
          DateRange.ThisQuarter,
          DateRange.LastQuarter,
        ].map<DropdownMenuItem<DateRange>>((DateRange value) {
          return DropdownMenuItem<DateRange>(
            onTap: widget.onPress(dropdownValue),
            value: value,
            child: Text(
              dictionary.entries.firstWhere((element) => element.key == value).value,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
