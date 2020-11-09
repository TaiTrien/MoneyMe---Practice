import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/screens/auth/components/rounded_button.dart';
import 'package:MoneyMe/screens/auth/signin/signin_controller.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
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
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text(
            'Bấm quay lại lần nữa để thoát',
            textAlign: TextAlign.center,
          ),
        ),
        child: Container(
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
                height: 120,
                width: 120,
                child: Image(
                  image: AssetImage('assets/icons/logo.png'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Manage your finance with us',
                style: kSubTitleTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    label: 'Số điện thoại',
                    iconData: Icons.phone,
                    keyboardType: TextInputType.number,
                    controller: controller.phoneNumberController,
                    validator: Validator.isPhoneNumber,
                    errorMessage: "Số điện thoại không hợp lệ",
                    maxLines: 1,
                  ),
                  CustomTextField(
                    label: 'Mật khẩu',
                    iconData: Icons.lock,
                    controller: controller.passwordController,
                    isObscured: false,
                    validator: Validator.isPassword,
                    errorMessage: "Mật khẩu phải bằng hoặc hơn 8 ký tự",
                    maxLines: 1,
                  ),
                  DefaultButton(
                    titleBtn: 'Đăng nhập',
                    onPressed: () => controller.handleSignIn(context),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/signUpScreen', (_) => false),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Chưa có tài khoản?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: ' Đăng ký ngay',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
