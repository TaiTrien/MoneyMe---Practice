part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {
  final List<Transaction> transactionsList;
  final Transaction currentTransaction;
  TransactionState({this.transactionsList, this.currentTransaction});

  get revenues {
    return transactionsList.where((transaction) => transaction.type == '1').toList();
  }

  get expenses {
    return transactionsList.where((transaction) => transaction.type == '2').toList();
  }
}

class TransactionblocInitial extends TransactionState {
  TransactionblocInitial() : super(transactionsList: null, currentTransaction: null);
  get revenues => null;
  get expenses => null;
}

class UpdateState extends TransactionState {
  UpdateState(
    TransactionState oldState, {
    List<Transaction> listTransactions,
    Transaction currentTransaction,
  }) : super(
          transactionsList: listTransactions ?? oldState.transactionsList,
          currentTransaction: currentTransaction ?? oldState.currentTransaction,
        );
}

class ResetState extends TransactionState {
  ResetState(
    TransactionState oldState, {
    List<Transaction> listTransactions,
    Transaction currentTransaction,
  }) : super(
          transactionsList: listTransactions ?? oldState.transactionsList,
          currentTransaction: currentTransaction,
        );
}
