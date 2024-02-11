part of 'wallet_cubit.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class LoadingWallet extends WalletState {}

class LoadWalletSuccess extends WalletState {
  final WalletModel wallet;

  const LoadWalletSuccess(this.wallet);

  @override
  List<Object?> get props => [wallet];
}

class LoadWalletError extends WalletState {
  final String error;

  const LoadWalletError(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdatingWallet extends WalletState {}

class UpdateWalletSuccess extends WalletState {}

class UpdateWalletError extends WalletState {
  final String error;

  const UpdateWalletError(this.error);

  @override
  List<Object?> get props => [error];
}

class DeletingWallet extends WalletState {}

class DeleteWalletSuccess extends WalletState {}

class DeleteWalletError extends WalletState {
  final String error;

  const DeleteWalletError(this.error);

  @override
  List<Object?> get props => [error];
}
