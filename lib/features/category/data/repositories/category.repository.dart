import 'package:dartz/dartz.dart';
import 'package:notes_application/features/category/data/datasources/category.api.service.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/category/domain/repositories/category.dart';
import 'package:notes_application/injection.container.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<List<Category>> getAllCategories() {
    return sl<CategoryApiService>().getAllCategories();
  }

  @override
  Future<Category> getCategoryById(int id) {
    return sl<CategoryApiService>().getCategoryById(id);
  }

  @override
  Future<Either> createCategory(Category category) {
    return sl<CategoryApiService>().createCategory(category);
  }

  @override
  Future<Either> updateCategory(int id, Category category) {
    return sl<CategoryApiService>().updateCategory(id, category);
  }

  @override
  Future<Either> deleteCategory(int id) {
    return sl<CategoryApiService>().deleteCategory(id);
  }
}