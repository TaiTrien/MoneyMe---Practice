part of 'transaction_bloc.dart';

@immutable
abstract class TransactionblocState {
  final List<Transaction> transactionsList;

  TransactionblocState({this.transactionsList});
}

class TransactionblocInitial extends TransactionblocState {
  TransactionblocInitial() : super(transactionsList: null);
}

class LoadingState extends TransactionblocState {
  LoadingState(TransactionblocState oldState, {List<Transaction> listTransactions}) : super(transactionsList: listTransactions ?? oldState.transactionsList);
}
