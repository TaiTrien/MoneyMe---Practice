import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:flutter/material.dart';

class JarSlider extends StatefulWidget {
  final Jar jar;
  final Function onChange;
  final Function getValue;
  final int remainPercentage;
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
  bool isIncrease;
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
            if (newValue <= oldValue) {
              isIncrease = false;
              //oldValue = newValue;
              value = newValue;
            } else {
              isIncrease = true;
              value = oldValue;
            }
            if (widget.remainPercentage > 0) oldValue = newValue;

            print('old value:  ' + oldValue.toString());
            print('new value:  ' + newValue.toString());
            print('is Increase: ' + isIncrease.toString());
            print('remainPercentage: ' + widget.remainPercentage.toString());

            if (isIncrease && widget.remainPercentage <= 0) return;

            widget.onChange(value: value, jarName: widget.jar.jarName.toLowerCase());
          },
          value: widget.getValue(jarName: widget.jar.jarName.toLowerCase()),
        ),
      ],
    );
  }
}
