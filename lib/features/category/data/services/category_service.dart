import 'package:wangku/core/data/services/sqlite_service.dart';
import 'package:wangku/features/category/data/models/category_model.dart';

import '../../../../core/constants/app_enums.dart';

class CategoryService {
  final _sqliteService = SqliteService();

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final database = await _sqliteService.database;
      final maps = await database.query('categories');
      final categories = <CategoryModel>[];

      for (Map<String, Object?> map in maps) {
        categories.add(CategoryModel.fromMap(map));
      }

      return categories;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CategoryModel>> getCategoriesByType(TransactionType type) async {
    try {
      final database = await _sqliteService.database;
      final maps = await database.query(
        'categories',
        where: 'transaction_type = ?',
        whereArgs: [type.name],
      );
      final categories = <CategoryModel>[];

      for (Map<String, Object?> map in maps) {
        categories.add(CategoryModel.fromMap(map));
      }

      return categories;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<CategoryModel> getCategoryById(int id) async {
    try {
      final database = await _sqliteService.database;
      final maps = await database.query(
        'categories',
        where: 'id = ?',
        whereArgs: [id],
      );
      final category = CategoryModel.fromMap(maps[0]);

      return category;
    } catch (e) {
      throw e.toString();
    }
  }
}
