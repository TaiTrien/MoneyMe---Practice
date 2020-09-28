part of 'transactionbloc_bloc.dart';

@immutable
abstract class TransactionblocState {
  final List<Transaction> listTransactions;

  TransactionblocState({this.listTransactions});
}

class TransactionblocInitial extends TransactionblocState {
  TransactionblocInitial() : super(listTransactions: null);
}

class LoadingState extends TransactionblocState {
  LoadingState(TransactionblocState oldState, {List<Transaction> listTransactions}) : super(listTransactions: listTransactions ?? oldState.listTransactions);
}
