import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:flutter/material.dart';

class JarSlider extends StatefulWidget {
  final Jar jar;
  final Function onChange;
  final Function onStop;
  final Function getValue;
  final int remainPercentage;
  const JarSlider({
    Key key,
    @required this.jar,
    @required this.onChange,
    @required this.getValue,
    this.remainPercentage,
    this.onStop,
  }) : super(key: key);

  @override
  _JarSliderState createState() => _JarSliderState();
}

class _JarSliderState extends State<JarSlider> {
  double value;
  TextEditingController percentController;
  @override
  void initState() {
    super.initState();
    percentController = TextEditingController();
    value = widget.getValue(jarName: widget.jar.jarName.toLowerCase());
    percentController.text = value.toInt().toString();
  }

  void updatePercent(double newValue) {
    if (widget.remainPercentage > 0) return;

    widget.onChange(value: newValue, jarName: widget.jar.jarName.toLowerCase());
    int value = widget.onStop(value: newValue, jarName: widget.jar.jarName.toLowerCase());
    percentController.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.jar.jarName + ' - ' + widget.jar.jarTitle),
        Row(
          children: [
            Container(
              width: size.width * 0.7,
              child: Slider(
                activeColor: kPrimaryColor,
                inactiveColor: kSecondaryColor,
                min: 0,
                max: 100,
                onChanged: (double newValue) {
                  value = newValue;
                  percentController.text = newValue.toInt().toString();
                  widget.onChange(value: value, jarName: widget.jar.jarName.toLowerCase());
                },
                onChangeEnd: (double newValue) {
                  int value = widget.onStop(value: newValue, jarName: widget.jar.jarName.toLowerCase());
                  percentController.text = value.toString();
                },
                value: widget.getValue(jarName: widget.jar.jarName.toLowerCase()),
              ),
            ),
            Expanded(
              child: Focus(
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    value = widget.getValue(jarName: widget.jar.jarName.toLowerCase());
                    updatePercent(value);
                  }
                },
                child: TextField(
                  controller: percentController,
                  cursorColor: kPrimaryColor,
                  maxLines: 1,
                  maxLength: 3,
                  decoration: InputDecoration(
                    hintText: 'Phần trăm %',
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    double percent = double.tryParse(value);

                    if (value.trim().isEmpty) {
                      percent = 0;
                      percentController.text = '';
                    }
                    if (percent > 100.0) {
                      Notify().error(message: 'Bạn đã nhập quá 100%');
                      percent = 100;
                    }
                    widget.onChange(value: percent, jarName: widget.jar.jarName.toLowerCase());
                  },
                  onSubmitted: (newValue) {
                    newValue = newValue.trim();
                    double percent = double.tryParse(newValue);
                    int value = widget.onStop(value: percent, jarName: widget.jar.jarName.toLowerCase());
                    percentController.text = value.toString();
                  },
                ),
              ),
            ),
            Text(
              '%',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
