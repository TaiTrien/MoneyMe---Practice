import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/transaction/add/add_controller.dart';
import 'package:MoneyMe/screens/transaction/add/components/note_textfield.dart';
import 'package:MoneyMe/screens/transaction/add/components/tag_button.dart';
import 'package:MoneyMe/screens/transaction/components/custom_datetime_picker.dart';
import 'package:MoneyMe/screens/transaction/components/money_formatter.dart';
import 'package:MoneyMe/screens/transaction/components/transaction_textfield.dart';
import 'package:MoneyMe/utils/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class AddTransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = AddController(context: context);
    return Material(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => Services.hideKeyboard(context),
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
                                  title: (state.selectedTag != null) ? (state.selectedTag.tagName ?? 'Chọn danh mục') : 'Chọn danh mục',
                                  iconName: (state.selectedTag != null) ? (state.selectedTag.icon.substring(4) ?? 'menu') : 'menu',
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
                                controller: controller.priceController,
                                formatter: MoneyTextFormatter(),
                                color: Colors.black,
                                onChange: controller.onDataChange,
                                onFocus: (isFocus) => controller.onFocus(isFocus),
                              ),
                              DateTimePicker(
                                label: 'Chọn thời gian',
                                iconData: Icons.calendar_today,
                                controller: controller.dateController,
                                onChange: controller.onDataChange,
                              ),
                              NoteTextField(
                                label: 'Ghi chú',
                                iconData: Icons.note,
                                controller: controller.descController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: controller.onDataChange,
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
      ),
    );
  }
}
