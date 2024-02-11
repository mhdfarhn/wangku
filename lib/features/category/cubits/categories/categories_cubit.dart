import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wangku/features/category/data/models/category_model.dart';
import 'package:wangku/features/category/data/services/category_service.dart';

import '../../../../core/constants/app_enums.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryService _service;
  CategoriesCubit(this._service) : super(CategoriesInitial());

  Future<void> loadCategories() async {
    emit(LoadingCategories());
    try {
      final categories = await _service.getAllCategories();
      emit(LoadCategoriesSuccess(categories));
    } catch (e) {
      emit(LoadCategoriesError(e.toString()));
    }
  }

  Future<void> loadCategoriesByType(TransactionType type) async {
    emit(LoadingCategories());
    try {
      final categories = await _service.getCategoriesByType(type);
      emit(LoadCategoriesSuccess(categories));
    } catch (e) {
      emit(LoadCategoriesError(e.toString()));
    }
  }
}
