import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData iconData;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const CustomTextField({
    Key key,
    @required this.label,
    @required this.controller,
    this.iconData,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconData,
            color: Colors.green,
          ),
          labelText: '$label',
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.green,
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
