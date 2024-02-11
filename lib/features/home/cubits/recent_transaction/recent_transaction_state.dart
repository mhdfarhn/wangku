part of 'recent_transaction_cubit.dart';

abstract class LoadRecentTransactionState extends Equatable {
  const LoadRecentTransactionState();
  @override
  List<Object?> get props => [];
}

class LoadRecentTransactionInitial extends LoadRecentTransactionState {}

class LoadingRecentTransaction extends LoadRecentTransactionState {}

class LoadRecentTransactionSuccess extends LoadRecentTransactionState {
  final Map<String, List<TransactionModel>> transactions;

  const LoadRecentTransactionSuccess(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class LoadRecentTransactionError extends LoadRecentTransactionState {
  final String error;

  const LoadRecentTransactionError(this.error);
  @override
  List<Object?> get props => [error];
}
