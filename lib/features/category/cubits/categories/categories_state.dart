part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class LoadingCategories extends CategoriesState {}

class LoadCategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  const LoadCategoriesSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}

class LoadCategoriesError extends CategoriesState {
  final String error;

  const LoadCategoriesError(this.error);

  @override
  List<Object?> get props => [error];
}
