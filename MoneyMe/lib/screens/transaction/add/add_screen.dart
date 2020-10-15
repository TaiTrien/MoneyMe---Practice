import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/account/components/inkwell_btn.dart';
import 'package:MoneyMe/screens/auth/components/custom_textfield.dart';
import 'package:MoneyMe/screens/transaction/add/add_controller.dart';
import 'package:MoneyMe/screens/transaction/add/components/tag_button.dart';
import 'package:MoneyMe/screens/transaction/components/custom_datetime_picker.dart';
import 'package:MoneyMe/screens/transaction/components/transaction_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

var currencyMask = new MaskTextInputFormatter(mask: '###,###,###,###');

class AddTransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = AddController(context: context);

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
                        BlocBuilder<TagBloc, TagState>(
                          builder: (context, state) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TagButton(
                                onTap: controller.toCategoriesScreen,
                                title: (state.selectedTag != null) ? state.selectedTag.tagName : 'Chọn danh mục',
                                iconName: (state.selectedTag != null) ? state.selectedTag.icon.substring(4) : 'menu',
                              ),
                            );
                          },
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
                              controller: controller.dateController,
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
                                onPressed: controller.handleAddTransaction,
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
