import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/screens/auth/components/rounded_button.dart';
import 'package:MoneyMe/screens/auth/signup/signup_controller.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
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
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Bấm quay lại lần nữa để thoát'),
        ),
        child: Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                          DefaultButton(
                            titleBtn: 'Đăng ký',
                            onPressed: () => controller.handleSignUp(context),
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/signInScreen', (_) => false),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Đã có tài khoản?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Đăng nhập ngay',
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
