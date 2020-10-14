import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/components/inkwell_btn.dart';
import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/screens/transaction/add/add_controller.dart';
import 'package:MoneyMe/screens/transaction/components/custom_datetime_picker.dart';
import 'package:MoneyMe/screens/transaction/components/transaction_textfield.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:flutter/material.dart';

var currencyMask = new MaskTextInputFormatter(mask: '###,###,###,###');

class AddTransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = new AddController(context: context);
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
                      horizontal: kDefaultPaddingHorizontal,
                      vertical: kDefaultPaddingVertical,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Thêm giao dịch',
                            style: kTitleTextStyle,
                          ),
                        ),
                        SizedBox(height: kDefaultPaddingVertical),
                        InkWellBtn(
                          titleBtn: 'Chọn hạng mục',
                          onTap: controller.toCategoriesScreen,
                          spashColor: kPrimaryColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TransactionTextField(
                              label: 'Số tiền',
                              iconData: Icons.attach_money,
                              keyboardType: TextInputType.number,
                              controller: controller.moneyController,
                              formatter: currencyMask,
                              color: Colors.black,
                            ),
                            DateTimePicker(
                              label: 'Chọn thời gian',
                              iconData: Icons.calendar_today,
                            ),
                            CustomTextField(
                              label: 'Ghi chú',
                              iconData: Icons.note,
                              controller: controller.noteController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                              child: FlatButton(
                                color: Colors.green[400],
                                textColor: Colors.white,
                                child: Text('Thêm giao dịch'),
                                onPressed: () {},
                              ),
                            ),
                          ],
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
