import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/api/transaction_api.dart';
import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/components/custom_dialog.dart';
import 'package:MoneyMe/components/custom_action_btn.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditController {
  BuildContext context;
  Transaction selectedTransaction;

  TagBloc _tagBloc;
  TransactionBloc _transactionBloc;
  Transaction currentTransaction;
  JarBloc _jarBloc;

  final dateController = TextEditingController();
  final descController = TextEditingController();
  final moneyController = TextEditingController();

  String date;
  String desc;
  String price;
  String tagID;

  EditController({this.context, this.selectedTransaction}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);

    currentTransaction = _transactionBloc.state.currentTransaction;
    initData();
  }

  void toCategoriesScreen() {
    Navigator.pushNamed(context, '/categoriesScreen');
  }

  initData() {
    moneyController.text = Formatter.formatMoney(selectedTransaction.price);
    dateController.text = Formatter.formatDate(selectedTransaction.date);
    descController.text = selectedTransaction.desc;
  }

  get tagName => selectedTransaction.tagName;
  get icon => selectedTransaction.icon.substring(4);

  onDataChange(value) {
    date = dateController.text.trim() ?? '';
    desc = descController.text.trim() ?? '';
    price = moneyController.text.trim() ?? '';
    tagID = (_tagBloc.state.selectedTag != null) ? _tagBloc.state.selectedTag.tagID : '';
    //to format price into new string
    price = price.replaceAll(new RegExp(r'[^\w\s]+'), '');

    Transaction transaction = new Transaction(date: date, desc: desc, price: price, tagID: tagID);
    _transactionBloc.add(GetCurrentTransaction(transaction));
  }

  resetData() {
    _tagBloc.add(ResetSelectedTag(null));
    _transactionBloc.add(ResetCurrentTransaction(null));

    moneyController.text = '0';
    descController.clear();
  }

  handleDeleteTransaction() async {
    int typeTransaction = int.tryParse(selectedTransaction.type);
    String inputID = selectedTransaction.inputId;

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

  handleAddTransaction() async {
    date = _transactionBloc.state.currentTransaction.date;
    desc = _transactionBloc.state.currentTransaction.desc;
    price = _transactionBloc.state.currentTransaction.price;
    tagID = (_tagBloc.state.selectedTag != null) ? _tagBloc.state.selectedTag.tagID : '';

    if (date.isEmpty || price.isEmpty || tagID.isEmpty) {
      Notify().error(
        message: 'Cần điền đầy đủ thông tin',
      );
      return;
    }
    if (_tagBloc.state.selectedTag == null) return;

    Transaction newTransaction = new Transaction(date: date, desc: desc, price: price, tagID: tagID);
    var data;

    data = await TransactionApi.editTransaction(inputID, newTransaction);

    //if (data.code != 200) return dialogFailed();
    //editSuccessfully();
  }

  deleteSuccessfully() async {
    await loadJarsData();
    await loadTransactionsData();
    Notify().success(message: "Xóa thành công", timeout: 8);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  editSuccessfully() async {
    await loadJarsData();
    await loadTransactionsData();
    resetData();
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
