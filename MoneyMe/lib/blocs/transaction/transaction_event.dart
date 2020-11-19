part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {
  final dynamic payload;
  TransactionEvent({this.payload});
}

class LoadTransactionsData extends TransactionEvent {
  LoadTransactionsData(List<Transaction> listTransactions) : super(payload: listTransactions);
}

class LoadStatisticTransaction extends TransactionEvent {
  LoadStatisticTransaction(List<Transaction> statisticTransactions) : super(payload: statisticTransactions);
}

class GetCurrentTransaction extends TransactionEvent {
  GetCurrentTransaction(Transaction currentTransaction) : super(payload: currentTransaction);
}

class ResetCurrentTransaction extends TransactionEvent {
  ResetCurrentTransaction(Transaction currentTransaction) : super(payload: currentTransaction);
}
