import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  @required
  final String items;

  const CustomDropdown({Key key, this.hintText, this.items}) : super(key: key);
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
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
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
