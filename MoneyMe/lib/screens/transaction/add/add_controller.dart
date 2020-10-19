import 'package:MoneyMe/api/jar_api.dart';
import 'package:MoneyMe/api/tag_api.dart';
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

  AddController({this.context}) {
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
    moneyController.text = (currentTransaction != null)
        ? Formatter.formatMoney(
            currentTransaction.price,
          )
        : 0.toString();
    dateController.text = (currentTransaction != null)
        ? currentTransaction.date
        : Formatter.mask
            .format(
              DateTime.now(),
            )
            .toString();

    descController.text = (currentTransaction != null) ? currentTransaction.desc : '';
  }

  onDataChange(value) {
    String date = dateController.text.trim() ?? '';
    String desc = descController.text.trim() ?? '';
    String price = moneyController.text.trim() ?? '';
    String tagID = (_tagBloc.state.selectedTag != null) ? _tagBloc.state.selectedTag.tagID : '';
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

  handleAddTransaction() async {
    String date = _transactionBloc.state.currentTransaction.date;
    String desc = _transactionBloc.state.currentTransaction.desc;
    String price = _transactionBloc.state.currentTransaction.price;
    String tagID = (_tagBloc.state.selectedTag != null) ? _tagBloc.state.selectedTag.tagID : '';

    if (date.isEmpty || price.isEmpty || tagID.isEmpty) {
      Notify().error(
        message: 'Cần điền đầy đủ thông tin',
      );
      return;
    }
    Transaction transaction = new Transaction(date: date, desc: desc, price: price, tagID: tagID);

    if (_tagBloc.state.selectedTag != null && _tagBloc.state.selectedTag.type == "2") {
      var data = await TransactionApi.spend(transaction);

      if (data.code != 200) return dialogFailed();
      addSuccessfully();
    } else {
      print('hihih');
    }
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

  addSuccessfully() async {
    await loadJarsData();
    await loadTransactionsData();
    resetData();
    dialogSuccessfully();
  }

  Future dialogSuccessfully() {
    return showDialog(
      context: context,
      builder: (context) => CustomDiaglog(
        title: "Hoàn tất",
        subTitle: "Giao dịch của bạn đã được thêm thành công",
        titleWidget: Image.asset(
          'assets/images/success.gif',
          fit: BoxFit.contain,
        ),
        actions: [
          CustomActionButton(
            titleBtn: 'Hủy',
            color: Colors.blue,
            colorTitle: Colors.white,
            onPress: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future dialogFailed() {
    return showDialog(
      context: context,
      builder: (context) => CustomDiaglog(
        title: "Thêm giao dịch thất bại",
        subTitle: "Vui lòng kiểm tra lại thông tin",
        titleWidget: Image.asset(
          'assets/images/noInternet.gif',
          fit: BoxFit.contain,
        ),
        actions: [
          CustomActionButton(
            titleBtn: 'Hủy',
            color: Colors.grey,
            colorTitle: Colors.white,
            onPress: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
