import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:flutter/material.dart';

class JarSlider extends StatefulWidget {
  final Jar jar;
  final Function onChange;
  final Function getValue;
  final double remainPercentage;
  const JarSlider({
    Key key,
    @required this.jar,
    @required this.onChange,
    @required this.getValue,
    this.remainPercentage,
  }) : super(key: key);

  @override
  _JarSliderState createState() => _JarSliderState();
}

class _JarSliderState extends State<JarSlider> {
  double value;
  double oldValue;
  @override
  void initState() {
    super.initState();
    oldValue = widget.getValue(jarName: widget.jar.jarName.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
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
            print(widget.remainPercentage);
            if (widget.remainPercentage < 0) return;

            if (newValue < oldValue) {
              value = newValue;
            } else {
              oldValue = newValue;
              value = oldValue;
            }
            widget.onChange(value: value, jarName: widget.jar.jarName.toLowerCase());
          },
          value: widget.getValue(jarName: widget.jar.jarName.toLowerCase()),
        ),
      ],
    );
  }
}
