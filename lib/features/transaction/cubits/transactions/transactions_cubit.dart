import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/services/image_service.dart';
import '../../data/models/transaction_model.dart';
import '../../data/services/transaction_service.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionService _transactionService;
  final ImageService _imageService;

  TransactionsCubit(
    this._transactionService,
    this._imageService,
  ) : super(TransactionsInitial());

  Future<void> loadAllTransactions() async {
    emit(LoadingTransactions());
    try {
      final transactions =
          await _transactionService.getAllTransactionGroupedByDay();
      emit(LoadTransactionsSuccess(transactions));
    } catch (e) {
      emit(LoadTransactionsError(e.toString()));
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    emit(AddingTransaction());
    String imagePath = transaction.imagePath;
    try {
      if (transaction.imagePath != '') {
        imagePath = await _imageService
            .storeImageToInternalStorage(transaction.imagePath);
        await _transactionService.createTransaction(
          transaction.copyWith(imagePath: imagePath),
        );
      } else {
        await _transactionService.createTransaction(transaction);
      }
      emit(AddTransactionSuccess());
    } catch (e) {
      emit(AddTransactionError(e.toString()));
    }
  }
}
