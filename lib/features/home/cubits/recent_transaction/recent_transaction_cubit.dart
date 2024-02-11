import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../transaction/data/models/transaction_model.dart';
import '../../../transaction/data/services/transaction_service.dart';

part 'recent_transaction_state.dart';

class RecentTransactionCubit extends Cubit<LoadRecentTransactionState> {
  final TransactionService _service;
  RecentTransactionCubit(this._service) : super(LoadRecentTransactionInitial());

  Future<void> loadRecentTransactions() async {
    emit(LoadingRecentTransaction());
    try {
      final transactions = await _service.getRecentTransactions();
      emit(LoadRecentTransactionSuccess(transactions));
    } catch (e) {
      emit(LoadRecentTransactionError(e.toString()));
    }
  }
}
