import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_enums.dart';
import '../../../core/data/services/shared_preferences_service.dart';
import '../../wallet/data/services/wallet_service.dart';

class AuthenticationCubit extends Cubit<AuthenticationStatus> {
  final SharedPreferencesService _sharedPreferencesService;
  final WalletService _walletService;
  AuthenticationCubit(this._sharedPreferencesService, this._walletService)
      : super(AuthenticationStatus.signedOut);

  void setAuthenticationStatus(AuthenticationStatus status) => emit(status);

  Future<void> loadAuthenticationStatus() async {
    try {
      final accountExist = await _sharedPreferencesService.isAccountExist();
      final walletExist = await _walletService.isWalletExist();
      if (!accountExist && !walletExist) {
        emit(AuthenticationStatus.signedOut);
      } else if (accountExist && !walletExist) {
        emit(AuthenticationStatus.accountCreated);
      } else {
        emit(AuthenticationStatus.signedIn);
      }
    } catch (e) {
      emit(AuthenticationStatus.signedOut);
    }
  }
}
