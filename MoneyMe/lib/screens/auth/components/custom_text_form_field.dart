import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    @required this.labelText,
    @required this.icon,
    this.helpText,
    this.keyboardType,
  }) : super(key: key);

  final String labelText;
  final Icon icon;
  final String helpText;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.green,
      validator: (value) => (value.isEmpty) ? 'Enter some text' : null,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: '$labelText',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.green,
        ),
        helperText: this.helpText,
      ),
      keyboardType: keyboardType,
    );
  }
}
