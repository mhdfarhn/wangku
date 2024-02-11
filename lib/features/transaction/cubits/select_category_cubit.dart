import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wangku/features/category/data/models/category_model.dart';

class SelectCategoryCubit extends Cubit<CategoryModel?> {
  SelectCategoryCubit() : super((null));

  void selectCategory(CategoryModel category) => emit(category);
  void removeCategory() => emit(null);
}
