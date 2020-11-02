import 'package:MoneyMe/models/tag.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  @required
  final List<dynamic> items;
  final Function onChanged;
  final dynamic value;

  const CustomDropdown({Key key, this.hintText, this.items, this.onChanged, this.value}) : super(key: key);
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  dynamic dropdownValue;

  @override
  void didUpdateWidget(CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    dropdownValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      value: widget.value ?? dropdownValue,
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
      hint: Text(
        widget.hintText,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (dynamic newValue) {
        widget.onChanged(newValue);
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: widget.items.map<DropdownMenuItem<dynamic>>((dynamic value) {
        return DropdownMenuItem<dynamic>(
          value: value,
          child: (value is Tag) ? Text(value.tagName) : Text(value.jarName + ' - ' + value.jarTitle),
        );
      }).toList(),
    );
  }
}
