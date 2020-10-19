import 'dart:async';

import 'package:MoneyMe/models/transaction.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionblocInitial());

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if (event is LoadTransactionsData) {
      yield UpdateState(state, listTransactions: event.payload);
    } else if (event is GetCurrentTransaction) {
      yield UpdateState(state, currentTransaction: event.payload);
    } else if (event is ResetCurrentTransaction) {
      yield ResetState(state, currentTransaction: event.payload);
    }
  }
}
