import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/change_password/change_password_controller.dart';
import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/utils/validator.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = ChangePasswordController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Đổi mật khẩu',
          style: kTitleTextStyle.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: kSecondaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(kDefaultPaddingHorizontal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPaddingHorizontal + 10,
                  vertical: kDefaultPaddingVertical + 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: 'Mật khẩu cũ',
                      iconData: Icons.lock,
                      keyboardType: TextInputType.number,
                      controller: controller.currentPasswordController,
                      validator: Validator.isPassword,
                      errorMessage: "Mật khẩu bao gồm chữ cái thường, chữ in hoa và ký tự đặc biệt",
                    ),
                    CustomTextField(
                      label: 'Mật khẩu mới',
                      iconData: Icons.lock,
                      controller: controller.newPasswordController,
                      isObscured: false,
                      validator: Validator.isPassword,
                      errorMessage: "Mật khẩu bao gồm chữ cái thường, chữ in hoa và ký tự đặc biệt",
                    ),
                    CustomTextField(
                      label: 'Nhập lại mật khẩu mới',
                      iconData: Icons.lock,
                      controller: controller.retypedPasswordController,
                      isObscured: false,
                      //validator: () => Validator.isRetypedPassword(newPassword, retypedPassword),
                      errorMessage: "Mật khẩu bao gồm chữ cái thường, chữ in hoa và ký tự đặc biệt",
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                      child: FlatButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text('Xác nhận'),
                        onPressed: () => controller.handleChangePassword(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
