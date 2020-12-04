import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/components/inkwell_btn.dart';
import 'package:MoneyMe/screens/account/inform_account/account_controller.dart';
import 'package:MoneyMe/screens/account/components/jar_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = new AccountController(context: context);
    var size = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Trang cá nhân',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: kSecondaryColor,
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height - 60),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: size.height - 60),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingHorizontal,
                        vertical: kDefaultPaddingVertical,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: kDefaultPaddingVertical),
                          Text(
                            'Thiết lập tỉ lệ cho các hũ',
                            style: kTitleTextStyle,
                          ),
                          SizedBox(height: 10.0),
                          BlocBuilder<JarBloc, JarState>(
                            builder: (context, state) {
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Phần trăm còn lại: ',
                                      style: kSubTitleTextStyle.copyWith(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: '${controller.percent.toInt()}%',
                                      style: kTitleTextStyle.copyWith(fontSize: 25.0, color: Colors.green[400]),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.jars.length ?? 0,
                            itemBuilder: (context, index) {
                              return BlocBuilder<JarBloc, JarState>(
                                builder: (context, state) {
                                  return JarSlider(
                                    jar: state.jarsList[index],
                                    onChange: controller.onSliderChange,
                                    getValue: controller.getValue,
                                    remainPercentage: controller.percent,
                                    onStop: controller.onSliderStop,
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  right: kDefaultPaddingHorizontal,
                                ),
                                child: FlatButton(
                                  color: Colors.green[400],
                                  textColor: Colors.white,
                                  child: Text(
                                    'Cập nhật',
                                  ),
                                  onPressed: controller.handleUpdatePercentage,
                                ),
                              ),
                            ],
                          ),
                          InkWellBtn(
                            titleBtn: 'Đổi mật khẩu',
                            onTap: controller.toChangePasswordScreen,
                            spashColor: kPrimaryColor,
                          ),
                          InkWellBtn(
                            titleBtn: 'Đăng xuất',
                            onTap: () => controller.signOut(context),
                            spashColor: Colors.red,
                          ),
                          SizedBox(
                            height: kDefaultPaddingVertical,
                          ),
                        ],
                      ),
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
