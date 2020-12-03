import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/transaction/add/components/note_textfield.dart';
import 'package:MoneyMe/screens/transaction/add/components/tag_button.dart';
import 'package:MoneyMe/screens/transaction/components/custom_datetime_picker.dart';
import 'package:MoneyMe/screens/transaction/components/money_formatter.dart';
import 'package:MoneyMe/screens/transaction/components/transaction_textfield.dart';
import 'package:MoneyMe/screens/transaction/edit/edit_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class EditTransactionScreen extends StatefulWidget {
  final selectedTransaction;

  const EditTransactionScreen({
    Key key,
    this.selectedTransaction,
  }) : super(key: key);

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  var controller;

  @override
  void initState() {
    super.initState();
    controller = EditController(context: context, currentTransaction: widget.selectedTransaction);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    Size size = MediaQuery.of(context).size;

    return Material(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: FlatButton(
              onPressed: controller.toExit,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Chỉnh sửa giao dịch',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: kSecondaryColor,
          ),
          body: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: size.height - 60,
              ),
              color: kSecondaryColor,
              padding: EdgeInsets.only(
                bottom: bottom,
                left: kDefaultPaddingHorizontal,
                right: kDefaultPaddingHorizontal,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                            'Thông tin giao dịch',
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
                                title: (state.selectedTag == null) ? controller.currentTransaction.tagName : state.selectedTag.tagName,
                                iconName: (state.selectedTag == null) ? controller.currentTransaction.icon.substring(4) : state.selectedTag.icon.substring(4),
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
                              onTap: controller.updatePrice,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                                  child: FlatButton(
                                    color: Colors.red[400],
                                    textColor: Colors.white,
                                    child: Text('Xóa'),
                                    onPressed: controller.handleDeleteTransaction,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVertical),
                                  child: FlatButton(
                                    color: Colors.green[400],
                                    textColor: Colors.white,
                                    child: Text('Sửa'),
                                    onPressed: controller.handleEditTransaction,
                                  ),
                                ),
                              ],
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
