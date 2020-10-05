import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:flutter/material.dart';

class JarSlider extends StatefulWidget {
  final Jar jar;
  final Function onChange;
  final Function getValue;
  final bool canSlide;
  final int remainPercentage;
  const JarSlider({
    Key key,
    @required this.jar,
    @required this.onChange,
    @required this.getValue,
    this.canSlide,
    this.remainPercentage,
  }) : super(key: key);

  @override
  _JarSliderState createState() => _JarSliderState();
}

class _JarSliderState extends State<JarSlider> {
  @override
  Widget build(BuildContext context) {
    double oldValue = widget.getValue(jarName: widget.jar.jarName.toLowerCase());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.jar.jarName + ' - ' + widget.jar.jarTitle),
        Slider(
          activeColor: kPrimaryColor,
          inactiveColor: kSecondaryColor,
          min: 0,
          max: 100,
          onChanged: (double newValue) {
            if (oldValue < newValue) {
              if (widget.remainPercentage > 0) {
                widget.onChange(value: newValue, jarName: widget.jar.jarName.toLowerCase());
                oldValue = newValue;
              } else {
                widget.onChange(value: oldValue, jarName: widget.jar.jarName.toLowerCase());
              }
            } else {
              widget.onChange(value: newValue, jarName: widget.jar.jarName.toLowerCase());
            }
          },
          value: widget.getValue(jarName: widget.jar.jarName.toLowerCase()),
        ),
      ],
    );
  }
}
