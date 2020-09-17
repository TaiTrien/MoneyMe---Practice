import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LoadingScreen extends StatefulWidget {
  static String screenID = 'LoadingScreen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var controller = new SignInController();
  @override
  void initState() {
    super.initState();
    checkUserSignedIn();
  }

  void checkUserSignedIn() async {
    controller.isSignedIn().then((isSignedIn) {
      String routeName = isSignedIn ? '/testScreen' : '/signInScreen';

      Navigator.pushReplacementNamed(context, routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          child: LiquidCircularProgressIndicator(
            value: 0.25, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(Colors
                .teal[200]), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors
                .white, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.teal,
            borderWidth: 5.0,
            direction: Axis
                .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
            center: Text(
              "Loading...",
              style: TextStyle(fontSize: 20.0, color: Colors.teal),
            ),
          ),
        ),
      ),
    );
  }
}
