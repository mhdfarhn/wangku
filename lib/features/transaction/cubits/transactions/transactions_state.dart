part of 'transactions_cubit.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

class TransactionsInitial extends TransactionsState {}

class LoadingTransactions extends TransactionsState {}

class LoadTransactionsSuccess extends TransactionsState {
  final Map<String, List<TransactionModel>> transactions;

  const LoadTransactionsSuccess(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class LoadTransactionsError extends TransactionsState {
  final String error;

  const LoadTransactionsError(this.error);

  @override
  List<Object?> get props => [error];
}

class AddingTransaction extends TransactionsState {}

class AddTransactionSuccess extends TransactionsState {}

class AddTransactionError extends TransactionsState {
  final String error;

  const AddTransactionError(this.error);

  @override
  List<Object?> get props => [error];
}
