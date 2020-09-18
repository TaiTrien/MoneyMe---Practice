import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/screens/auth/components/rounded_button.dart';
import 'package:MoneyMe/screens/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static String screenID = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isValid;
  @override
  Widget build(BuildContext context) {
    var controller = new SignUpController();
    var size = MediaQuery.of(context).size;
    var errorText;
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
              height: size.height * 0.8,
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
                          blurRadius: 10.0,
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
                          color: Color(0xFF4dc9cb),
                        ),
                        CustomTextField(
                          label: 'Họ tên đầy đủ',
                          iconData: Icons.account_circle,
                          controller: controller.nameController,
                        ),
                        CustomTextField(
                          label: 'Số điện thoại',
                          iconData: Icons.phone,
                          keyboardType: TextInputType.number,
                          controller: controller.phoneNumberController,
                          errorText: errorText,
                          onChanged: (value) {
                            setState(() {
                              errorText = controller.validateInfo(value);
                            });
                          },
                        ),
                        CustomTextField(
                          label: 'Mật khẩu',
                          iconData: Icons.lock,
                          controller: controller.passwordController,
                          isObscured: true,
                        ),
                        CustomTextField(
                          label: 'Nhập lại mật khẩu',
                          iconData: Icons.lock,
                          controller: controller.retypePasswordController,
                          isObscured: true,
                        ),
                        RoudedButton(
                          titleBtn: 'Đăng ký',
                          onPressed: controller.handleSignUp,
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
          ),
        ),
      ),
    );
  }
}
