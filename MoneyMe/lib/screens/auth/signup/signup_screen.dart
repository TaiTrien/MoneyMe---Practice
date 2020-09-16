import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/screens/auth/components/rounded_button.dart';
import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String screenID = 'SignUpScreen';
  @override
  Widget build(BuildContext context) {
    var controller = new SignInController();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.black87,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
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
                      'Đăng ký',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: Color(0xFF4dc9cb),
                  ),
                  CustomTextField(
                    label: 'Họ tên đầy đủ',
                    iconData: Icons.account_circle,
                  ),
                  CustomTextField(
                    label: 'Số điện thoại',
                    iconData: Icons.phone,
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextField(
                    label: 'Mật khẩu',
                    iconData: Icons.lock,
                  ),
                  CustomTextField(
                    label: 'Nhập lại mật khẩu',
                    iconData: Icons.lock,
                  ),
                  RoudedButton(
                    titleBtn: 'Đăng ký',
                    onPressed: () {},
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10.0,
                      bottom: 15.0,
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black54,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Trở lại đăng nhập',
                            style: TextStyle(
                              color: Color(0xFF4dc9cb),
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
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
