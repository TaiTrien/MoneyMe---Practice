import 'package:MoneyMe/screens/auth/signin/signin_screen.dart';
import 'package:MoneyMe/screens/auth/signup/signup_screen.dart';
import 'package:MoneyMe/screens/mainscreen/test_controller.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  static String screenID = 'TestScreen';
  @override
  Widget build(BuildContext context) {
    TestController controller = new TestController();

    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      child: Container(
        color: Colors.white,
        child: FlatButton(
          onPressed: () async {
            await controller.deleteToken();
            Navigator.pop(context);
          },
          child: Text(
            'Đăng xuất',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
