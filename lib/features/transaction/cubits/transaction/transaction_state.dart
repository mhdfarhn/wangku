part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class LoadingTransaction extends TransactionState {}

class LoadTransactionSuccess extends TransactionState {
  final TransactionModel transaction;

  const LoadTransactionSuccess(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class LoadTransactionError extends TransactionState {
  final String error;

  const LoadTransactionError(this.error);

  @override
  List<Object?> get props => [];
}

class UpdatingTransaction extends TransactionState {}

class UpdateTransactionSuccess extends TransactionState {}

class UpdateTransactionError extends TransactionState {
  final String error;

  const UpdateTransactionError(this.error);

  @override
  List<Object?> get props => [error];
}

class DeletingTransaction extends TransactionState {}

class DeleteTransactionSuccess extends TransactionState {}

class DeleteTransactionError extends TransactionState {
  final String error;

  const DeleteTransactionError(this.error);

  @override
  List<Object?> get props => [error];
}
