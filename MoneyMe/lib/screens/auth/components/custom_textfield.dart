import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData iconData;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String errorMessage;
  final bool isObscured;
  final Function onChanged;
  final Function validator;

  const CustomTextField({
    Key key,
    @required this.label,
    @required this.controller,
    this.iconData,
    this.keyboardType,
    this.onChanged,
    this.errorMessage,
    this.isObscured = false,
    this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String value = "";
  Color color;
  String message;
  @override
  void initState() {
    super.initState();
    color = Colors.grey;
    message = null;
  }

  String get errorMessage {
    bool isValid = widget.validator(value);
    return isValid ? null : widget.errorMessage;
  }

  Color get selectedColor {
    bool isValid = widget.validator(value);
    return isValid ? Colors.grey : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: widget.controller,
        cursorColor: color,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.iconData,
            color: color,
          ),
          labelText: '${widget.label}',
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: color,
            ),
          ),
          labelStyle: TextStyle(
            color: color,
          ),
          errorText: message,
        ),
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          setState(
            () {
              this.value = value;
              color = selectedColor;
              message = errorMessage;
            },
          );
        },
        obscureText: widget.isObscured,
      ),
    );
  }
}
