import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wangku/features/wallet/data/models/wallet_model.dart';
import 'package:wangku/features/wallet/data/services/wallet_service.dart';

part 'wallets_state.dart';

class WalletsCubit extends Cubit<WalletsState> {
  final WalletService _service;
  WalletsCubit(this._service) : super(WalletsInitial());

  Future<void> addWallet(WalletModel wallet) async {
    emit(AddingWallet());
    try {
      await _service.createWallet(wallet);
      emit(AddWalletSuccess());
    } catch (e) {
      emit(AddWalletError(e.toString()));
    }
  }

  Future<void> loadWallets() async {
    emit(LoadingWallets());
    try {
      final wallets = await _service.getAllWallets();
      emit(LoadWalletsSuccess(wallets));
    } catch (e) {
      emit(LoadWalletsError(e.toString()));
    }
  }
}
