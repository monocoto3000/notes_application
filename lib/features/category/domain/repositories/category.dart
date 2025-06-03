import 'package:dartz/dartz.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
  Future<Category> getCategoryById(int id);
  Future<Either> createCategory(Category category);
  Future<Either> updateCategory(int id, Category category);
  Future<Either> deleteCategory(int id);
}