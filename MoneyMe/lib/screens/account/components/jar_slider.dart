import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:flutter/material.dart';

class JarSlider extends StatefulWidget {
  final Jar jar;
  final Function onChange;
  final Function getValue;
  final Function onStop;
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
  double oldValue;
  bool isIncrease;
  var percentController;
  @override
  void initState() {
    super.initState();
    oldValue = widget.getValue(jarName: widget.jar.jarName.toLowerCase());
    percentController = TextEditingController();
    percentController.text = oldValue.toInt().toString() + '%';
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
              width: size.width * 0.6,
              child: Slider(
                activeColor: kPrimaryColor,
                inactiveColor: kSecondaryColor,
                min: 0,
                max: 100,
                onChanged: (double newValue) {
                  value = newValue;
                  percentController.text = newValue.toInt().toString() + '%';
                  widget.onChange(value: value, jarName: widget.jar.jarName.toLowerCase());
                },
                onChangeEnd: (double newValue) {
                  widget.onStop(value: newValue, jarName: widget.jar.jarName.toLowerCase());
                },
                value: widget.getValue(jarName: widget.jar.jarName.toLowerCase()),
              ),
            ),
            Expanded(
              child: TextField(
                onTap: () {
                  setState(
                    () {},
                  );
                },
                controller: percentController,
                cursorColor: kPrimaryColor,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Phần trăm %',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(
                    () {},
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
