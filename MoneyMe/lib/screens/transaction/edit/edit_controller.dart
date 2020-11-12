import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/api/transaction_api.dart';
import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/tag.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/screens/categories/categories_screen.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:MoneyMe/utils/services.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditController {
  BuildContext context;
  Transaction currentTransaction;
  Tag selectedTag;
  String date;
  String desc;
  String price;
  String tagID;
  Notify notify = Notify();

  TransactionBloc _transactionBloc;
  JarBloc _jarBloc;
  TagBloc _tagBloc;

  final dateController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();

  EditController({this.context, this.currentTransaction}) {
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);
    _tagBloc = BlocProvider.of<TagBloc>(context);

    displayData();
  }

  displayData() {
    Transaction tempTransaction = _transactionBloc.state.currentTransaction ?? currentTransaction;

    priceController.text = Formatter.formatMoney(tempTransaction.price);
    bool isDateFormatted = tempTransaction.date.contains(new RegExp(r'[/\-\_]'));
    if (!isDateFormatted)
      dateController.text = Formatter.formatDate(tempTransaction.date);
    else
      dateController.text = tempTransaction.date;

    descController.text = tempTransaction.desc;
  }

  handleEditTransaction() async {
    updatePrice();
    String inputID = currentTransaction.inputId;
    String date = dateController.text.trim() ?? '';
    String desc = descController.text.trim() ?? '';
    String price = priceController.text ?? '';
    String tagID = (_tagBloc.state.selectedTag == null) ? currentTransaction.tagID : _tagBloc.state.selectedTag.tagID;
    //to format price into new string
    price = price.replaceAll(new RegExp(r'[^\w\s]+'), '');
    if (date.isEmpty) {
      Notify notify = Notify();
      return notify.error(message: 'Vui lòng điền ngày giao dịch');
    }

    if (price.isEmpty) {
      Notify notify = Notify();
      return notify.error(message: 'Vui lòng điền số tiền giao dịch');
    }

    if (tagID.isEmpty) {
      Notify notify = Notify();
      return notify.error(message: 'Vui lòng chọn hạng mục');
    }

    if (int.tryParse(price) < 100) {
      Notify notify = Notify();
      return notify.error(message: 'Vui lòng nhập số tiền lớn hơn 100 đồng');
    }

    currentTransaction.date = date;
    currentTransaction.desc = desc;
    currentTransaction.price = price;
    currentTransaction.tagID = tagID;

    var data = await TransactionApi.editTransaction(inputID, currentTransaction);

    if (data.code != 200) return notify.error(message: 'Sửa giao dịch thất bại', timeout: 8);

    editSuccessfully();
  }

  editSuccessfully() async {
    await loadJarsData();
    await loadTransactionsData();
    resetData();
    Notify().success(message: 'Sửa thành công');
    Navigator.pop(context);
  }

  resetData() {
    _tagBloc.add(ResetSelectedTag(null));
    _transactionBloc.add(ResetCurrentTransaction(null));

    priceController.text = '0';
    descController.clear();
  }

  //to handle when delete a transaction
  handleDeleteTransaction() async {
    int typeTransaction = int.tryParse(currentTransaction.type);

    String inputID = currentTransaction.inputId;

    var respone;

    CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      showCancelBtn: true,
      title: '',
      confirmBtnText: 'Xóa',
      confirmBtnColor: Colors.red,
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () async {
        respone = await TransactionApi.delete(typeTransaction, inputID);
        if (respone.code != 200) return Notify().error(message: 'Xóa thất bại', timeout: 8);

        deleteSuccessfully();
      },
      text: 'Bạn có chắc xóa giao dịch này chứ ?',
    );
  }

  deleteSuccessfully() async {
    await loadJarsData();
    await loadTransactionsData();
    notify.success(message: "Xóa thành công", timeout: 8);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  onDataChange(value) {
    date = dateController.text.trim() ?? '';
    desc = descController.text.trim() ?? '';
    price = priceController.text;
    //to format price into new string
    price = price.replaceAll(new RegExp(r'[^\w\s]+'), '');

    tagID = (_tagBloc.state.selectedTag != null) ? _tagBloc.state.selectedTag.tagID : '';

    Transaction transaction = new Transaction(date: date, desc: desc, price: price, tagID: tagID);
    _transactionBloc.add(GetCurrentTransaction(transaction));
  }

  onFocus(isFocus) {
    if (!isFocus) updatePrice();
  }

  updatePrice() {
    priceController.text = priceController.text.replaceAll(new RegExp(r'[^\w\s]+'), '');
    priceController.text = roundPrice(price: priceController.text).toString();
    price = priceController.text;
    currentTransaction.price = price;
    priceController.text = Formatter.formatMoney(priceController.text);
  }

  roundPrice({String price}) {
    int roundedPrice = int.tryParse(price);
    if (roundedPrice == null) return 0;
    if (roundedPrice == null || roundedPrice == 0) return 0;
    if (roundedPrice < 100) return roundedPrice;

    int offSet = (100 - roundedPrice % 100);
    if (offSet == 100) return roundedPrice;
    roundedPrice += offSet;
    return roundedPrice;
  }

  void toCategoriesScreen() async {
    selectedTag = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesScreen(
          typeScreen: TypeScreen.edit,
          currentTransaction: currentTransaction,
        ),
      ),
    );
    _tagBloc.add(SelectTag(selectedTag));
    Services.hideKeyboard(context);
  }

  void toExit() {
    Navigator.pop(context);
  }

  Future<void> loadJarsData() async {
    var jarsListData;
    List<Jar> jarsList = List<Jar>();
    jarsListData = await JarApi.getJarsList();

    for (int i = 0; i < jarsListData.data.length; i++) {
      Jar jar = Jar.map(jarsListData.data[i]);
      jarsList.add(jar);
    }
    _jarBloc.add(UpdateJarsData(jarsList));
  }

  Future<void> loadTransactionsData() async {
    var transactionsListData;
    List<Transaction> transactionsList = List<Transaction>();

    transactionsListData = await TransactionApi.getTransactionsList();
    int transactionsListLength = int.parse(transactionsListData.data["total"]);

    for (int i = 0; i < transactionsListLength; i++) {
      Transaction transaction = Transaction.map(transactionsListData.data, i);
      transactionsList.add(transaction);
    }
    _transactionBloc.add(LoadTransactionsData(transactionsList));
  }
}
