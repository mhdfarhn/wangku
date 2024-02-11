part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}

class CreatingAccount extends AccountState {}

class CreateAccountSuccess extends AccountState {}

class CreateAccountError extends AccountState {
  final String error;

  const CreateAccountError(this.error);

  @override
  List<Object?> get props => [error];
}

class LoadingAccount extends AccountState {}

class LoadAccountSuccess extends AccountState {
  final String name;

  const LoadAccountSuccess(this.name);

  @override
  List<Object?> get props => [name];
}

class LoadAccountFailed extends AccountState {}

class LoadAccountError extends AccountState {
  final String error;

  const LoadAccountError(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdatingAccount extends AccountState {}

class UpdateAccountSuccess extends AccountState {}

class UpdateAccountError extends AccountState {
  final String error;

  const UpdateAccountError(this.error);

  @override
  List<Object?> get props => [error];
}

class DeletingAccount extends AccountState {}

class DeleteAccountSuccess extends AccountState {}

class DeleteAccountError extends AccountState {
  final String error;

  const DeleteAccountError(this.error);

  @override
  List<Object?> get props => [error];
}
