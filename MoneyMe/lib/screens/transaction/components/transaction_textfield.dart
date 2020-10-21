import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionTextField extends StatefulWidget {
  final String label;
  final IconData iconData;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Color color;
  final TextInputFormatter formatter;
  final Function onChange;
  final Function onTap;
  const TransactionTextField({
    Key key,
    @required this.label,
    @required this.controller,
    this.iconData,
    this.keyboardType,
    this.color,
    this.formatter,
    this.onChange,
    this.onTap,
  }) : super(key: key);

  @override
  _TransactionTextFieldState createState() => _TransactionTextFieldState();
}

class _TransactionTextFieldState extends State<TransactionTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 80.0),
        child: TextField(
          onTap: widget.onTap,
          onChanged: widget.onChange,
          textAlign: TextAlign.end,
          controller: widget.controller
            ..selection = TextSelection.collapsed(
              offset: widget.controller.text.length,
            ),
          inputFormatters: [widget.formatter],
          cursorColor: widget.color,
          maxLength: 12,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.iconData,
              color: widget.color,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.color,
              ),
            ),
            labelText: widget.label,
            labelStyle: TextStyle(
              color: widget.color,
            ),
          ),
          keyboardType: widget.keyboardType,
        ),
      ),
    );
  }
}
