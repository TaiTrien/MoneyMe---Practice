import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/api/transaction_api.dart';
import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditController {
  BuildContext context;
  Transaction currentTransaction;

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

    initData();
  }

  initData() {
    priceController.text = Formatter.formatMoney(currentTransaction.price);
    dateController.text = Formatter.formatDate(currentTransaction.date);
    descController.text = currentTransaction.desc;
  }

  void toCategoriesScreen() {
    Navigator.pushNamed(context, '/categoriesScreen');
  }

  get tagName => currentTransaction.tagName;
  get icon => currentTransaction.icon.substring(4);

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
    Notify().success(message: "Xóa thành công", timeout: 8);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  // to handle when edit a transaction

  handleEditTransaction() async {
    String inputID = currentTransaction.inputId;
    String date = dateController.text.trim() ?? '';
    String desc = descController.text.trim() ?? '';
    String price = priceController.text ?? '';
    String tagID = currentTransaction.tagID;
    //to format price into new string
    price = price.replaceAll(new RegExp(r'[^\w\s]+'), '');

    currentTransaction.date = date;
    currentTransaction.desc = desc;
    currentTransaction.price = price;
    currentTransaction.tagID = tagID;

    var data = await TransactionApi.editTransaction(inputID, currentTransaction);

    if (data.code != 200) return Notify().error(message: 'Sửa giao dịch thất bại', timeout: 8);

    editSuccessfully();
  }

  editSuccessfully() async {
    await loadJarsData();
    await loadTransactionsData();
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
