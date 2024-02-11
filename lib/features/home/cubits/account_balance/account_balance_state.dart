part of 'account_balance_cubit.dart';

abstract class AccountBalanceState extends Equatable {
  const AccountBalanceState();
  @override
  List<Object?> get props => [];
}

class AccountBalanceInitial extends AccountBalanceState {}

class LoadingAccountBalance extends AccountBalanceState {}

class LoadAccountBalanceSuccess extends AccountBalanceState {
  final int balance;

  const LoadAccountBalanceSuccess(this.balance);

  @override
  List<Object?> get props => [balance];
}

class LoadAccountBalanceError extends AccountBalanceState {
  final String error;

  const LoadAccountBalanceError(this.error);

  @override
  List<Object?> get props => [error];
}
