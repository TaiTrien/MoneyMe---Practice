import 'package:flutter/material.dart';

import 'components/custom_text_form_field.dart';
import 'components/signin_and_signup_form.dart';

class SignUpScreen extends StatelessWidget {
  static String screenID = 'SignUpScreen';
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
            SignInOrSignUpForm(
              formTitle: 'Đăng ký',
              btnTitle: 'Trang đăng nhập tài khoản',
              routing: () => Navigator.pop(context),
              listTextFormField: [
                CustomTextFormFieldd(
                  labell: "OK",
                  labelText: 'Họ tên đầy đủ',
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.green,
                  ),
                  helpText: 'Không được bỏ trống họ và tên',
                  keyboardType: TextInputType.number,
                ),
                CustomTextFormFieldd(
                  labell: "OK",
                  labelText: 'Số điện thoại',
                  icon: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  helpText: 'Không được bỏ trống số điện thoại',
                  keyboardType: TextInputType.visiblePassword,
                ),
                CustomTextFormFieldd(
                  labell: "OK",
                  labelText: 'Mật khẩu',
                  icon: Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  helpText: 'Không được bỏ trống mật khẩu',
                  keyboardType: TextInputType.visiblePassword,
                ),
                CustomTextFormFieldd(
                  labell: "OK",
                  labelText: 'Nhập lại mật khẩu',
                  icon: Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  helpText: 'Không được bỏ trống mật khẩu',
                  keyboardType: TextInputType.visiblePassword,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
