import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wangku/features/wallet/data/models/wallet_model.dart';
import 'package:wangku/features/wallet/data/services/wallet_service.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletService _service;
  WalletCubit(this._service) : super(WalletInitial());

  Future<void> loadWallet(int id) async {
    emit(LoadingWallet());
    try {
      final wallet = await _service.getWalletById(id);
      emit(LoadWalletSuccess(wallet));
    } catch (e) {
      emit(LoadWalletError(e.toString()));
    }
  }

  Future<void> updateWallet(WalletModel wallet) async {
    emit(UpdatingWallet());
    try {
      await _service.updateWallet(wallet);
      emit(UpdateWalletSuccess());
    } catch (e) {
      emit(UpdateWalletError(e.toString()));
    }
  }

  Future<void> deleteWallet(int id) async {
    emit(DeletingWallet());
    try {
      await _service.deleteWallet(id);
      emit(DeleteWalletSuccess());
    } catch (e) {
      emit(DeleteWalletError(e.toString()));
    }
  }
}
