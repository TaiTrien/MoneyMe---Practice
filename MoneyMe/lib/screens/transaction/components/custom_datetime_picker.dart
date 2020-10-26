import 'package:MoneyMe/utils/formatter.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final String label;
  final IconData iconData;
  final TextEditingController controller;
  final Function onChange;
  const DateTimePicker({
    Key key,
    @required this.label,
    this.iconData,
    this.controller,
    this.onChange,
  }) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: widget.onChange,
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Ngày giao dịch',
            prefixIcon: Icon(
              widget.iconData,
              color: Colors.black,
            ),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
          ),
          controller: widget.controller,
        ),
      ),
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
          locale: Locale('vi'),
          helpText: 'Chọn ngày giao dịch',
          cancelText: 'Hủy',
          confirmText: 'Chọn',
        ).then(
          (value) => setState(
            () => {
              _selectedDate = value ?? _selectedDate,
              widget.controller.text = Formatter.mask.format(_selectedDate).toString(),
              if (widget.onChange != null) widget.onChange(_selectedDate),
            },
          ),
        );
      },
    );
  }
}
