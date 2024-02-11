import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/services/image_service.dart';
import '../../data/models/transaction_model.dart';
import '../../data/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionService _transactionService;
  final ImageService _imageService;

  TransactionCubit(
    this._transactionService,
    this._imageService,
  ) : super(TransactionInitial());

  Future<void> loadTransaction(int id) async {
    emit(LoadingTransaction());
    try {
      final transaction = await _transactionService.getTransaction(id);
      emit(LoadTransactionSuccess(transaction));
    } catch (e) {
      emit(LoadTransactionError(e.toString()));
    }
  }

  Future<void> updateTransaction({
    required TransactionModel transaction,
    required int initialAmount,
    required String initialImagePath,
  }) async {
    emit(UpdatingTransaction());
    String imagePath = transaction.imagePath;
    try {
      await _imageService.removeImageFromInternalStorage(initialImagePath);
      if (imagePath != '') {
        imagePath = await _imageService
            .storeImageToInternalStorage(transaction.imagePath);
        await _transactionService.updateTransaction(
          transaction: transaction.copyWith(imagePath: imagePath),
          initialAmount: initialAmount,
        );
      } else {
        await _transactionService.updateTransaction(
          transaction: transaction,
          initialAmount: initialAmount,
        );
      }
      emit(UpdateTransactionSuccess());
    } catch (e) {
      emit(UpdateTransactionError(e.toString()));
    }
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    emit(DeletingTransaction());
    try {
      await _transactionService.deleteTransaction(transaction);
      await _imageService.removeImageFromInternalStorage(transaction.imagePath);
      emit(DeleteTransactionSuccess());
    } catch (e) {
      throw e.toString();
    }
  }
}
