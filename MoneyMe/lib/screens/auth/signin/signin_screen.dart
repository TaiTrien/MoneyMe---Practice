import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/screens/auth/components/rounded_button.dart';
import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static String screenID = 'SignInScreen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var controller = new SignInController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: kPrimaryColor,
                  ),
                  CustomTextField(
                    label: 'Số điện thoại',
                    iconData: Icons.phone,
                    keyboardType: TextInputType.number,
                    controller: controller.phoneNumberController,
                    validator: Validator.isPhoneNumber,
                    errorMessage: "Số điện thoại không hợp lệ",
                  ),
                  CustomTextField(
                    label: 'Mật khẩu',
                    iconData: Icons.lock,
                    controller: controller.passwordController,
                    isObscured: false,
                    validator: Validator.isPassword,
                    errorMessage: "Mật khẩu bao gồm chữ cái thường, chữ in hoa và ký tự đặc biệt",
                  ),
                  RoudedButton(
                    titleBtn: 'Đăng nhập',
                    onPressed: () => controller.handleSignIn(context),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10.0,
                      bottom: 15.0,
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/signUpScreen', (_) => false),
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
                            'Đăng ký tài khoản mới',
                            style: kTitleTextStyle,
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
