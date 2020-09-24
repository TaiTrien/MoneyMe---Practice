import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'loading_controller.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoadingController controller = LoadingController(context: context);

    return Scaffold(
      body: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          child: LiquidCircularProgressIndicator(
            value: 0.25, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(Colors.teal[200]), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.teal,
            borderWidth: 5.0,
            direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
            center: Text(
              "Loading... ",
              style: TextStyle(fontSize: 20.0, color: Colors.teal),
            ),
          ),
        ),
      ),
    );
  }
}
