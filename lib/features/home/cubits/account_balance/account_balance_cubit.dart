import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../wallet/data/services/wallet_service.dart';

part 'account_balance_state.dart';

class AccountBalanceCubit extends Cubit<AccountBalanceState> {
  final WalletService _service;
  AccountBalanceCubit(this._service) : super(AccountBalanceInitial());

  Future<void> loadAccountBalance() async {
    emit(LoadingAccountBalance());
    try {
      final balance = await _service.getAccountBalance();
      emit(LoadAccountBalanceSuccess(balance));
    } catch (e) {
      emit(LoadAccountBalanceError(e.toString()));
    }
  }
}
