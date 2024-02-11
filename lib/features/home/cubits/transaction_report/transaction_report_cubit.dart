import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_enums.dart';
import '../../../transaction/data/services/transaction_service.dart';

part 'transaction_report_state.dart';

class TransactionReportCubit extends Cubit<TransactionReportState> {
  final TransactionService _service;

  TransactionReportCubit(this._service) : super(TransactionReportInitial());

  Future<void> loadTransactionReport() async {
    emit(LoadingTransactionReport());
    try {
      final income =
          await _service.getTransactionReport(TransactionType.income);
      final expense =
          await _service.getTransactionReport(TransactionType.expense);
      emit(LoadTransactionReportSuccess(
        income: income,
        expense: expense,
      ));
    } catch (e) {
      emit(LoadTransactionReportError(e.toString()));
    }
  }
}
