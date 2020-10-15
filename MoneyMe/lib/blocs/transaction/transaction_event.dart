part of 'transaction_bloc.dart';

@immutable
abstract class TransactionblocEvent {
  final dynamic payload;
  TransactionblocEvent({this.payload});
}

class LoadTransactionsData extends TransactionblocEvent {
  LoadTransactionsData(List<Transaction> listTransactions) : super(payload: listTransactions);
}
