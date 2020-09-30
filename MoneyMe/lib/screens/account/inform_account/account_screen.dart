import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/inform_account/account_controller.dart';
import 'package:MoneyMe/screens/account/components/jar_slider.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = new AccountController(context: context);
    return Material(
      child: SafeArea(
        child: Container(
          color: kSecondaryColor,
          height: double.infinity,
          padding: EdgeInsets.all(kDefaultPaddingHorizontal),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40.0,
                          color: kPrimaryColor,
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
                        Text(
                          'Thiết lập tỉ lệ cho các hũ',
                          style: kTitleTextStyle,
                        ),
                        SizedBox(height: 10.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Phần trăm còn lại: ',
                                style: kSubTitleTextStyle.copyWith(color: Colors.black),
                              ),
                              TextSpan(
                                text: '${controller.remainPercentage}%',
                                style: kTitleTextStyle.copyWith(fontSize: 25.0, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.jarsList.length ?? 0,
                          itemBuilder: (context, index) {
                            return JarSlider(
                              jar: controller.jarsList[index],
                              onChange: controller.onChange,
                              getValue: controller.getValue,
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Text(
                                  'Đổi mật khẩu',
                                ),
                                onPressed: () => controller.toChangePasswordScreen(),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              FlatButton(
                                color: Colors.red,
                                textColor: Colors.white,
                                child: Text('Đăng xuất'),
                                onPressed: () => controller.signOut(context),
                              ),
                            ],
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
