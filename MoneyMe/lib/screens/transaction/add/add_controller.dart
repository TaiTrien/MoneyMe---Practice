import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/api/transaction_api.dart';
import 'package:MoneyMe/blocs/jars/jarbloc_bloc.dart';
import 'package:MoneyMe/blocs/tag/tag_bloc.dart';
import 'package:MoneyMe/blocs/transaction/transaction_bloc.dart';
import 'package:MoneyMe/helpers/notify.dart';
import 'package:MoneyMe/models/jar.dart';
import 'package:MoneyMe/models/transaction.dart';
import 'package:MoneyMe/utils/formatter.dart';
import 'package:MoneyMe/utils/services.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddController {
  BuildContext context;
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

  AddController({this.context}) {
    _tagBloc = BlocProvider.of<TagBloc>(context);
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    _jarBloc = BlocProvider.of<JarBloc>(context);

    currentTransaction = _transactionBloc.state.currentTransaction;
    initData();
  }

  void toCategoriesScreen() {
    Navigator.pushNamed(context, '/categoriesScreen');
    Services.hideKeyboard(context);
  }

  initData() {
    moneyController.text = (currentTransaction != null)
        ? Formatter.formatMoney(
            currentTransaction.price,
          )
        : 0.toString();
    dateController.text = (currentTransaction != null)
        ? currentTransaction.date
        : Formatter.dateFormat
            .format(
              DateTime.now(),
            )
            .toString();

    descController.text = (currentTransaction != null) ? currentTransaction.desc : '';
  }

  onDataChange(value) {
    date = dateController.text.trim() ?? '';
    desc = descController.text.trim() ?? '';
    price = moneyController.text;
    price = price.replaceAll(new RegExp(r'[^\w\s]+'), '');
    //price =  price /1000
    // print("rounded price: " + ((int.tryParse(price) % 1000).toString()));
    tagID = (_tagBloc.state.selectedTag != null) ? _tagBloc.state.selectedTag.tagID : '';
    //to format price into new string

    Transaction transaction = new Transaction(date: date, desc: desc, price: price, tagID: tagID);
    _transactionBloc.add(GetCurrentTransaction(transaction));
  }

  resetData() {
    _tagBloc.add(ResetSelectedTag(null));
    _transactionBloc.add(ResetCurrentTransaction(null));

    moneyController.text = '0';
    descController.clear();
  }

  handleAddTransaction() async {
    date = _transactionBloc.state.currentTransaction.date;
    desc = _transactionBloc.state.currentTransaction.desc;
    price = _transactionBloc.state.currentTransaction.price;
    tagID = (_tagBloc.state.selectedTag != null) ? _tagBloc.state.selectedTag.tagID : '';

    if (date.isEmpty || price.isEmpty || tagID.isEmpty) {
      Notify notify = Notify();
      return notify.error(message: 'Cần điền đầy đủ thông tin');
    }
    if (_tagBloc.state.selectedTag == null) return;

    Transaction newTransaction = new Transaction(date: date, desc: desc, price: price, tagID: tagID);
    var data;
    switch (_tagBloc.state.selectedTag.type) {
      case "1":
        List<Map<String, dynamic>> listMapsTag = List<Map<String, dynamic>>();
        List<Jar> jarsList = _jarBloc.state.jarsList;

        listMapsTag = jarsList
            .map((jar) => {
                  "jar_id": jar.jarID,
                  "percentage": jar.percentage,
                  "price": int.tryParse(price) * int.tryParse(jar.percentage) / 100,
                })
            .toList();
        data = await TransactionApi.income(newTransaction, listMapsTag);
        break;

      case "2":
        data = await TransactionApi.spend(newTransaction);
        break;
    }

    if (data.code != 200)
      return CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Thêm giao dịch thất bại',
        confirmBtnText: 'Đóng',
        confirmBtnColor: Colors.green,
        text: "Thêm giao dịch thất bại",
      );

    addSuccessfully();
  }

  addSuccessfully() async {
    await loadJarsData();
    await loadTransactionsData();
    resetData();
    Services.showKeyBoard(context);
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: 'Hoàn tất',
      confirmBtnText: 'Xong',
      confirmBtnColor: Colors.green,
      text: "Giao dịch của bạn đã được thêm thành công",
    );
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
