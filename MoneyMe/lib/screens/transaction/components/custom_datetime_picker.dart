import 'package:MoneyMe/utils/formater.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final String label;
  final Function onTap;
  final IconData iconData;
  const DateTimePicker({
    Key key,
    @required this.label,
    this.onTap,
    this.iconData,
  }) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.iconData,
              color: Colors.black,
            ),
            labelText: Formatter.format.format(_selectedDate).toString(),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
          helpText: 'Chọn ngày giao dịch',
          cancelText: 'Hủy',
          confirmText: 'Chọn',
        ).then((value) => setState(() => _selectedDate = value ?? _selectedDate));
      },
    );
  }
}
