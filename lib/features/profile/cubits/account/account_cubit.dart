import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/services/shared_preferences_service.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final SharedPreferencesService _service;
  AccountCubit(this._service) : super(AccountInitial());

  Future<void> createAccount(String name) async {
    emit(CreatingAccount());
    try {
      await _service.createAccount(name);
      emit(CreateAccountSuccess());
    } catch (e) {
      emit(CreateAccountError(e.toString()));
    }
  }

  Future<void> loadAccount() async {
    emit(LoadingAccount());
    try {
      final name = await _service.getAccount();
      if (name != null) {
        emit(LoadAccountSuccess(name));
      } else {
        emit(LoadAccountFailed());
      }
    } catch (e) {
      emit(LoadAccountError(e.toString()));
    }
  }

  Future<void> updateAccount(String name) async {
    emit(UpdatingAccount());
    try {
      await _service.updateAccount(name);
      emit(UpdateAccountSuccess());
    } catch (e) {
      emit(UpdateAccountError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(DeletingAccount());
    try {
      await _service.removeAccount();
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(DeleteAccountError(e.toString()));
    }
  }
}
