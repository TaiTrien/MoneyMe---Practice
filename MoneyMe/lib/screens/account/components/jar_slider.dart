import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:flutter/material.dart';

class JarSlider extends StatefulWidget {
  final Jar jar;
  final Function onChange;
  final Function getValue;
  const JarSlider({
    Key key,
    @required this.jar,
    @required this.onChange,
    @required this.getValue,
    // @required this.controller,
    // @required this.index,
  }) : super(key: key);

  @override
  _JarSliderState createState() => _JarSliderState();
}

class _JarSliderState extends State<JarSlider> {
  @override
  Widget build(BuildContext context) {
    //var currentValue = widget.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.jar.jarName + ' - ' + widget.jar.jarTitle),
        Slider(
          activeColor: kPrimaryColor,
          inactiveColor: kSecondaryColor,
          min: 0,
          max: 100,
          onChanged: (double value) {
            setState(() {
              widget.onChange(value: value, jarName: widget.jar.jarName.toLowerCase());
            });
          },
          value: widget.getValue(jarName: widget.jar.jarName.toLowerCase()),
        ),
      ],
    );
  }
}
