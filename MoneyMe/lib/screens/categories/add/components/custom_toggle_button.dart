import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final List<Widget> children;
  final Function onPress;

  const CustomToggle({
    Key key,
    @required this.children,
    @required this.onPress,
  }) : super(key: key);
  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  List<bool> _selections;

  @override
  void initState() {
    super.initState();
    _selections = [true, false];
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      selectedColor: Colors.white,
      color: Colors.black,
      fillColor: kPrimaryColor,
      isSelected: _selections,
      children: widget.children,
      borderRadius: BorderRadius.circular(30.0),
      borderColor: kTextColor,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selections.length; i++) {
            _selections[i] = i == index;
          }
        });
      },
    );
  }
}
