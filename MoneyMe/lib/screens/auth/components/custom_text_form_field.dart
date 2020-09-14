import 'package:flutter/material.dart';

class CustomTextFormFieldd extends StatefulWidget {
  const CustomTextFormFieldd({
    Key key,
    this.counter = 10,
    @required this.labelText,
    @required this.icon,
    @required this.helpText,
    @required this.keyboardType,
    String labell,
  })  : _labell = labell,
        super(key: key);

  final int counter;
  final String labelText;
  final Icon icon;
  final String helpText;
  final TextInputType keyboardType;
  final String _labell;

  @override
  _CustomTextFormFielddState createState() => _CustomTextFormFielddState();
}

class _CustomTextFormFielddState extends State<CustomTextFormFieldd> {
  @override
  Widget build(BuildContext context) {
    // var textController = TextEditingController(text: 'acbc');
    // print(labell);

    return TextFormField(
      // controller: textController,
      onChanged: (value) {
        print(widget.labelText);
      },
      cursorColor: Colors.green,
      validator: (value) => (value.isEmpty) ? 'Enter some text' : null,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        labelText:
            '${widget.labelText} ${widget._labell} --- ${widget.counter}',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.green,
        ),
        helperText: this.widget.helpText,
      ),
      keyboardType: widget.keyboardType,
    );
  }
}
