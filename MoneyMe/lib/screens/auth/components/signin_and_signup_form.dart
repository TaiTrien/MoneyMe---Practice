import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class SignInAndSignUpForm extends StatefulWidget {
  @override
  _SignInAndSignUpFormState createState() => _SignInAndSignUpFormState();
}

class _SignInAndSignUpFormState extends State<SignInAndSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: 'Số điện thoại',
            icon: Icon(
              Icons.phone,
              color: Colors.green,
            ),
            helpText: 'Không được bỏ trống số điện thoại',
            keyboardType: TextInputType.number,
          ),
          CustomTextFormField(
            labelText: 'Mật khẩu',
            icon: Icon(
              Icons.lock,
              color: Colors.green,
            ),
            helpText: 'Không được bỏ trống số mật khẩu',
          ),
        ],
      ),
    );
  }
}
