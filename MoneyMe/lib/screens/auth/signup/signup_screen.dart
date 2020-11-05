import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/screens/auth/components/rounded_button.dart';
import 'package:MoneyMe/screens/auth/signup/signup_controller.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static String screenID = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var controller = SignUpController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
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
                          blurRadius: 20.0,
                          color: Colors.black87,
                          offset: Offset(0, 10),
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
                          color: kPrimaryColor,
                        ),
                        CustomTextField(
                          label: 'Họ và tên đầy đủ',
                          iconData: Icons.account_circle,
                          controller: controller.nameController,
                          validator: Validator.isName,
                          errorMessage: "Họ tên không hợp lệ",
                          maxLines: 1,
                        ),
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
                          errorMessage: "Mật khẩu dài hơn 8 ký tự",
                          maxLines: 1,
                        ),
                        CustomTextField(
                          label: 'Nhập lại mật khẩu',
                          iconData: Icons.lock,
                          controller: controller.retypedPasswordController,
                          isObscured: false,
                          validator: (value) => (value == controller.passwordController.text),
                          errorMessage: "Mật khẩu nhập lại không khớp",
                          maxLines: 1,
                        ),
                        RoudedButton(
                          titleBtn: 'Đăng ký',
                          onPressed: () => controller.handleSignUp(context),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 10.0,
                            bottom: 15.0,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/signInScreen', (_) => false),
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
                                    color: kPrimaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
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
          ),
        ),
      ),
    );
  }
}
