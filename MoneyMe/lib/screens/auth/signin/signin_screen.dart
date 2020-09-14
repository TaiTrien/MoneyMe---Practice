import 'package:MoneyMe/screens/auth/components/custom_text_form_field.dart';
import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:MoneyMe/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import '../components/signin_and_signup_form.dart';

class SignInScreen extends StatelessWidget {
  static String screenID = 'SignInScreen';
  @override
  Widget build(BuildContext context) {
    var controller = new SignInController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image(
                image: AssetImage('assets/icons/logo.png'),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    width: double.infinity,
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: Color(0xFF4dc9cb),
                  ),
                  TextField(
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      labelText: 'Số điện thoại',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      labelText: 'Mật khẩu',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xFF4dc9cb),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
