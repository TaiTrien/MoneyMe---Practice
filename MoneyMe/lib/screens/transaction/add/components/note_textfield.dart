import 'package:flutter/material.dart';

class NoteTextField extends StatefulWidget {
  final String label;
  final IconData iconData;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String errorMessage;
  final bool isObscured;
  final Function onChanged;
  final Function validator;
  final Function onTap;
  final int maxLines;

  const NoteTextField({
    Key key,
    @required this.label,
    @required this.controller,
    this.iconData,
    this.keyboardType,
    this.onChanged,
    this.errorMessage,
    this.isObscured = false,
    this.validator,
    this.onTap,
    this.maxLines,
  }) : super(key: key);

  @override
  _NoteTextFieldState createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {
  String value = "";
  Color color;
  String message;
  bool isValid;
  @override
  void initState() {
    super.initState();
    color = Colors.black;
    message = null;
  }

  String get errorMessage {
    isValid = widget.validator(value);
    return isValid ? null : widget.errorMessage;
  }

  Color get selectedColor {
    isValid = widget.validator(value);
    return isValid ? Colors.grey : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 80.0),
        child: TextField(
          onTap: widget.onTap,
          controller: widget.controller,
          cursorColor: color,
          maxLines: widget.maxLines,
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
          onChanged: widget.onChanged,
          obscureText: widget.isObscured,
        ),
      ),
    );
  }
}
