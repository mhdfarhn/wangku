import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_enums.dart';
import '../../../transaction/data/services/transaction_service.dart';

part 'spend_frequency_state.dart';

class SpendFrequencyCubit extends Cubit<SpendFrequencyState> {
  final TransactionService _service;

  SpendFrequencyCubit(this._service) : super(SpendFrequencyInitial());

  Future<void> loadSpendFrequency() async {
    emit(LoadingSpendFrequency());
    try {
      final transactions = await _service.getAllTransactions();
      if (transactions.isNotEmpty) {
        double maxX = (transactions.length - 1).toDouble();
        double minY = 0;
        double maxY = 0;
        final spots = <FlSpot>[];

        for (final (index, transaction) in transactions.indexed) {
          final amount = transaction.type == TransactionType.expense
              ? -transaction.amount
              : transaction.amount;

          if (minY == 0) {
            minY = amount.toDouble();
          } else if (minY > amount) {
            minY = amount.toDouble();
          }

          if (maxY == 0) {
            maxY = amount.toDouble();
          } else if (maxY < amount) {
            maxY = amount.toDouble();
          }

          spots.add(FlSpot(index.toDouble(), amount.toDouble()));
        }
        emit(
          LoadSpendFrequencySuccess(
            maxX: maxX,
            minY: minY,
            maxY: maxY,
            spots: spots,
          ),
        );
      } else if (transactions.length == 1) {
        final amount = transactions[0].type == TransactionType.expense
            ? -transactions[0].amount
            : transactions[0].amount;
        emit(LoadOneSpendFrequencySuccess(amount.toDouble()));
      } else {
        emit(NoSpendFrequency());
      }
    } catch (e) {
      emit(LoadSpendFrequencyError(e.toString()));
    }
  }
}
