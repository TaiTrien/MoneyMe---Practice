import 'package:flutter/material.dart';

import 'form_with_dynamic_textfield_amounts.dart';
import 'custom_text_form_field.dart';

class SignInOrSignUpForm extends StatelessWidget {
  final List<dynamic> listTextFormField;
  final String formTitle, btnTitle;
  final Function signIn;
  final Function signUp;
  final Function routing;

  SignInOrSignUpForm(
      {Key key,
      this.formTitle,
      this.btnTitle,
      this.listTextFormField,
      this.signIn,
      this.signUp,
      this.routing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
            child: Text(
              '$formTitle',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF4dc9cb),
            ),
          ),
          Container(
            height: 300.0,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
            child: CustomForm(
              listTextFormField: this.listTextFormField,
            ),
          ),
          GestureDetector(
            onTap: (formTitle == 'Đăng nhập') ? this.signIn : this.signUp,
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                '$formTitle',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF4dc9cb),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: GestureDetector(
              onTap: this.routing,
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.0,
                    color: Colors.black87,
                  ),
                  Text(
                    '$btnTitle',
                    style: TextStyle(
                      color: Color(0xFF4dc9cb),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
