part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {
  final dynamic payload;
  TransactionEvent({this.payload});
}

class LoadTransactionsData extends TransactionEvent {
  LoadTransactionsData(List<Transaction> listTransactions) : super(payload: listTransactions);
}

class GetCurrentTransaction extends TransactionEvent {
  GetCurrentTransaction(Transaction currentTransaction) : super(payload: currentTransaction);
}
