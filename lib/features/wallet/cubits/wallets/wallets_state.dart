part of 'wallets_cubit.dart';

abstract class WalletsState extends Equatable {
  const WalletsState();

  @override
  List<Object> get props => [];
}

class WalletsInitial extends WalletsState {}

class AddingWallet extends WalletsState {}

class AddWalletSuccess extends WalletsState {}

class AddWalletError extends WalletsState {
  final String error;

  const AddWalletError(this.error);

  @override
  List<Object> get props => [error];
}

class LoadingWallets extends WalletsState {}

class LoadWalletsSuccess extends WalletsState {
  final List<WalletModel> wallets;

  const LoadWalletsSuccess(this.wallets);

  @override
  List<Object> get props => [wallets];
}

class LoadWalletsError extends WalletsState {
  final String error;

  const LoadWalletsError(this.error);

  @override
  List<Object> get props => [error];
}
