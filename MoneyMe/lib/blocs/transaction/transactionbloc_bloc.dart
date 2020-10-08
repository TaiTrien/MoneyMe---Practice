import 'dart:async';

import 'package:MoneyMe/models/transaction.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transactionbloc_event.dart';
part 'transactionbloc_state.dart';

class TransactionBloc extends Bloc<TransactionblocEvent, TransactionblocState> {
  TransactionBloc() : super(TransactionblocInitial());

  @override
  Stream<TransactionblocState> mapEventToState(
    TransactionblocEvent event,
  ) async* {
    if (event is LoadTransactionsData) {
      yield LoadingState(state, listTransactions: event.payload);
    }
  }
}
